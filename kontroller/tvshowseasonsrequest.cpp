#include "tvshowseasonsrequest.h"
#include "client.h"
#include "file.h"

namespace eu
{
namespace tgcm
{
namespace kontroller
{

TvShowSeasonsRequest::TvShowSeasonsRequest(QObject *parent) : QObject(parent),
    success(false)
{

}

TvShowSeasonsRequest::~TvShowSeasonsRequest()
{
    for(File* file : seasons)
        file->deleteLater();
    seasons.clear();
}

void TvShowSeasonsRequest::start(int tvshowid)
{
    QJsonObject parameters;
    parameters.insert("tvshowid", tvshowid);
    QJsonArray properties;
    properties.push_back(QString("season"));
    parameters.insert("properties", properties);
    QJsonObject sort;
    sort.insert("order", QLatin1String("ascending"));
    sort.insert("method", QLatin1String("season"));
    parameters.insert("sort", sort);
    auto message = QJsonRpcMessage::createRequest("VideoLibrary.GetSeasons", parameters);
    QJsonRpcServiceReply* reply = Client::current().send(message);
    if(reply)
        connect(reply, &QJsonRpcServiceReply::finished, this,
                [tvshowid, this]() { this->parseSeasonsResult_(tvshowid); });
    else
        emit finished();
}

void TvShowSeasonsRequest::parseSeasonsResult_(int tvshowid)
{
    QJsonRpcServiceReply* reply = dynamic_cast<QJsonRpcServiceReply*>(sender());
    if(reply)
    {
        QJsonRpcMessage response = reply->response();
        QJsonObject obj = response.toObject();
        if(obj.find("result") != obj.end())
        {
            QJsonValue result = obj.take("result");
            if(result.type() == QJsonValue::Object)
            {
                QJsonValue files;
                files = result.toObject().take("seasons");
                if(files.type() == QJsonValue::Array)
                {
                    QJsonArray res = files.toArray();
                    for(QJsonArray::const_iterator it = res.begin(); it != res.end(); ++it)
                    {
                        File* file = new File();
                        if((*it).type() == QJsonValue::Object)
                        {
                            QJsonObject obj = (*it).toObject();
                            QJsonValue val = obj.value("label");
                            if(val.type() == QJsonValue::String)
                                file->setLabel(val.toString());
                            val = obj.value("season");
                            if(val.type() == QJsonValue::Double)
                                file->setFile(QString::number(tvshowid) + "|" + QString::number(val.toDouble()));
                            file->setFiletype("season");
                            file->setType("season");
                            this->seasons.push_back(file);
                        }
                    }
                }
            }
        }
        success = true;
    }
    emit finished();
}

}
}
}
