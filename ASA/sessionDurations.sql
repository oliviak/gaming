-- Session durations of each player
WITH Durations AS
(
    SELECT
        PlayerId, GameId, time as EndTime, Latitude, Longitude, City, Country, DATEDIFF(second, LAST(time) OVER (
            PARTITION BY PlayerId, GameId
            LIMIT DURATION(second, 300)
            WHEN GameActivity = '1'
        ), time) as Duration
    FROM
        Input TIMESTAMP BY time
    WHERE
        GameActivity = '0'
)

SELECT GameId, PlayerId, EndTime, Duration AS DurationInSeconds INTO outSQL FROM Durations
SELECT PlayerId as Player, GameId as Game, EndTime, Latitude, Longitude, City, Country, Duration INTO outBlob FROM Durations
SELECT PlayerId as Player, GameId as Game, EndTime, Latitude, Longitude, City, Country, Duration INTO outPBI FROM Durations


WITH Durations AS\r\n(\r\n\tSELECT\r\n\t\tPlayerId, GameId, time as EndTime, Latitude, Longitude, City, Country, DATEDIFF(second, LAST(time) OVER (\r\n\t\t\tPARTITION BY PlayerId, GameId\r\n\t\t\tLIMIT DURATION(second, 300)\r\n\t\t\tWHEN GameActivity = '1'\r\n\t\t), time) as Duration\r\n\tFROM\r\n\t\tInput TIMESTAMP BY time\r\n\tWHERE\r\n\t\tGameActivity = '0'\r\n)\r\nSELECT GameId, PlayerId, EndTime, Duration AS DurationInSeconds INTO outSQL FROM Durations\r\nSELECT PlayerId as Player, GameId as Game, EndTime, Latitude, Longitude, City, Country, Duration INTO outBlob FROM Durations\r\nSELECT PlayerId as Player, GameId as Game, EndTime, Latitude, Longitude, City, Country, Duration INTO outPBI FROM Durations