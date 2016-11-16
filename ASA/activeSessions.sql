-- Number of active sessions per game ID

WITH ActiveSessions AS
(
    SELECT
        GameId, PlayerId, Country, City, System.timestamp as WindowEnd, Count(*) as NumberOfStarts
    FROM
        Input timestamp by time
    GROUP BY
        HoppingWindow(second, 300, 10), GameId, PlayerId, Country, City
    HAVING
        MIN(GameActivity) = 1
),
CCU AS
(
    SELECT
        GameId, System.timestamp as timewindow, Country, City, COUNT(PlayerId) as NumActiveSessions
    FROM
        ActiveSessions
    GROUP BY
        GameId, Country, City, SlidingWindow(second, 1)
)


SELECT * INTO outBlobCCUs FROM CCU
SELECT * INTO outPBI FROM CCU
SELECT GameId, timewindow AS EndTime, NumActiveSessions AS NumberPlayers INTO outSQL FROM CCU


WITH ActiveSessions AS\r\n(\r\n\tSELECT\r\n\t\tGameId, PlayerId, Country, City, System.timestamp as WindowEnd, Count(*) as NumberOfStarts\r\n\tFROM\r\n\t\tInput timestamp by time\r\n\tGROUP BY\r\n\t\tHoppingWindow(second, 300, 10), GameId, PlayerId, Country, City\r\n\tHAVING\r\n\t\tMIN(GameActivity) = 1\r\n),\r\nCCU AS\r\n(\r\n\tSELECT\r\n\t\tGameId, System.timestamp as timewindow, Country, City, COUNT(PlayerId) as NumActiveSessions\r\n\tFROM\r\n\t\tActiveSessions\r\n\tGROUP BY\r\n\t\tGameId, Country, City, SlidingWindow(second, 1)\r\n)\r\nSELECT * INTO outBlobCCUs FROM CCU\r\nSELECT * INTO outPBI FROM CCU\r\nSELECT GameId, timewindow AS EndTime, NumActiveSessions AS NumberPlayers INTO outSQL FROM CCU
