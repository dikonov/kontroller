#ifndef EU_TGCM_KONTROLLER_PLAYER_H
#define EU_TGCM_KONTROLLER_PLAYER_H

#include <QObject>
#include <QTimer>
#include "subtitle.h"
#include <QQmlListProperty>
#include "audiostream.h"

namespace eu
{
namespace tgcm
{
namespace kontroller
{

class Player : public QObject
{
    Q_OBJECT

    int playerId_;
    QString type_;
    QString current_;
    int speed_;
    int playlistPosition_;
    double percentage_;
    int totalTime_;
    int time_;

    QTimer timer_;

    bool shuffled_ = false;
    bool canMove_ = false;
    bool canRepeat_ = false;
    bool canShuffle_ = false;
    int repeat_ = 0;
    bool live_ = false;
    bool partyMode_ = false;
    bool subtitlesEnabled_ = false;
    bool canSeek_ = false;
    int playlistId_ = -1;
    std::vector<Subtitle*> subtitles_;
    int currentSubtitleIndex_ = -1;
    std::vector<AudioStream*> audioStreams_;
    int currentAudioStreamIndex_ = -1;


public:
    explicit Player(QObject *parent = 0);

    Q_PROPERTY(int playerId READ playerId WRITE setPlayerId NOTIFY playerIdChanged)
    Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(QString current READ current WRITE setCurrent NOTIFY currentChanged)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int playlistPosition READ playlistPosition WRITE setPlaylistPosition NOTIFY playlistPositionChanged)
    Q_PROPERTY(double percentage READ percentage WRITE setPercentage NOTIFY percentageChanged)
    Q_PROPERTY(int time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(int totalTime READ totalTime WRITE setTotalTime NOTIFY totalTimeChanged)
    Q_PROPERTY(bool shuffled READ shuffled WRITE setShuffled NOTIFY shuffledChanged)
    Q_PROPERTY(bool canMove READ canMove WRITE setCanMove NOTIFY canMoveChanged)
    Q_PROPERTY(bool canRepeat READ canRepeat WRITE setCanRepeat NOTIFY canRepeatChanged)
    Q_PROPERTY(bool canShuffle READ canShuffle WRITE setCanShuffle NOTIFY canShuffleChanged)
    Q_PROPERTY(int repeat READ repeat WRITE setRepeat NOTIFY repeatChanged)
    Q_PROPERTY(bool live READ live WRITE setLive NOTIFY liveChanged)
    Q_PROPERTY(bool partyMode READ partyMode WRITE setPartyMode NOTIFY partyModeChanged)
    Q_PROPERTY(bool canSeek READ canSeek WRITE setCanSeek NOTIFY canSeekChanged)
    Q_PROPERTY(int playlistId READ playlistId WRITE setPlaylistId NOTIFY playlistIdChanged)
   // Q_PROPERTY(bool subtitlesEnabled READ subtitlesEnabled WRITE setSubtitlesEnabled NOTIFY subtitlesChanged)
    Q_PROPERTY(QQmlListProperty<eu::tgcm::kontroller::Subtitle> subtitles READ subtitles NOTIFY subtitlesChanged)
    Q_PROPERTY(int currentSubtitleIndex READ currentSubtitleIndex WRITE setCurrentSubtitleIndex NOTIFY currentSubtitleIndexChanged)
    Q_PROPERTY(QQmlListProperty<eu::tgcm::kontroller::AudioStream> audioStreams READ audioStreams NOTIFY audioStreamsChanged)
    Q_PROPERTY(int currentAudioStreamIndex READ currentAudioStreamIndex WRITE setCurrentAudioStreamIndex NOTIFY currentAudioStreamIndexChanged)

    /*!
     * \brief playerId id of the player
     * \return
     */
    int playerId() const;
    Q_INVOKABLE void setPlayerId(int playerId);

    QString type() const;
    void setType(const QString &type);

    QString current() const;
    void setCurrent(const QString &current);

    int speed() const;
    void setSpeed(int speed);

    int playlistPosition() const;
    void setPlaylistPosition(int playlistPosition);

    double percentage() const;

    int time() const;

    int totalTime() const;

    bool shuffled() const;

    bool canMove() const;

    bool canRepeat() const;

    bool canShuffle() const;

    int repeat() const;

    bool live() const;

    bool partyMode() const;

    bool subtitlesEnabled() const;

    bool canSeek() const
    {
        return canSeek_;
    }

    int playlistId() const
    {
        return playlistId_;
    }

    int currentSubtitleIndex() const
    {
        return currentSubtitleIndex_;
    }

    QQmlListProperty<Subtitle> subtitles();

    void setSubtitles(std::vector<Subtitle*> && subtitles, int currentSubtitleIndex);

    QQmlListProperty<AudioStream> audioStreams();

    void setAudioStreams(std::vector<AudioStream*>&& audioStreams, int currentAudioStreamIndex);

    int currentAudioStreamIndex() const
    {
        return currentAudioStreamIndex_;
    }

signals:
    void playerIdChanged();
    void typeChanged();
    void currentChanged();
    void speedChanged();
    void playlistPositionChanged();
    void percentageChanged(double percentage);
    void totalTimeChanged(int totalTime);
    void timeChanged(int time);

    void shuffledChanged(bool shuffled);

    void canMoveChanged(bool canMove);

    void canRepeatChanged(bool canRepeat);

    void canShuffleChanged(bool canShuffle);

    void repeatChanged(int repeat);

    void liveChanged(bool live);

    void partyModeChanged(bool partyMode);

    void canSeekChanged(bool canSeek);

    void playlistIdChanged(int playlistId);

    void currentSubtitleIndexChanged();
    void subtitlesChanged();

    void audioStreamsChanged();
    void currentAudioStreamIndexChanged();

public slots:
    void setPercentage(double percentage);
    void setTime(int time);
    void setTotalTime(int totalTime);
    void setShuffled(bool shuffled);

    void setCanMove(bool canMove);

    void setCanRepeat(bool canRepeat);

    void setCanShuffle(bool canShuffle);

    void setRepeat(int repeat);

    void setLive(bool live);

    void setPartyMode(bool partyMode);

//    void setSubtitlesEnabled(bool subtitlesEnabled);

    void setCanSeek(bool canSeek)
    {
        if (canSeek_ == canSeek)
            return;

        canSeek_ = canSeek;
        emit canSeekChanged(canSeek);
    }

    void setPlaylistId(int playlistId)
    {
        if (playlistId_ == playlistId)
            return;

        playlistId_ = playlistId;
        emit playlistIdChanged(playlistId);
    }

    void setCurrentSubtitleIndex(int index)
    {
        if(currentSubtitleIndex_ != index)
        {
            currentSubtitleIndex_ = index;
            emit currentSubtitleIndexChanged();
        }
    }

    void setCurrentAudioStreamIndex(int index)
    {
        if(currentAudioStreamIndex_ != index)
        {
            currentAudioStreamIndex_ = index;
            emit currentAudioStreamIndexChanged();
        }
    }

private slots:
    void updateTimer_();
};

}
}
}
#endif // EU_TGCM_KONTROLLER_PLAYER_H
