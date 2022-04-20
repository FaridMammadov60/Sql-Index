CREATE DATABASE SPOTIFY

USE SPOTIFY

CREATE TABLE Artists (
Id int primary key identity,
[Name] nvarchar(100) not null )

CREATE TABLE Albums (
Id int primary key identity,
[Name] nvarchar(100) not null
)
CREATE TABLE Musics (
Id int primary key identity,
[Name] nvarchar(100) not null,
TotalSecond float not null,
ListenerCount int not null,
ArtistsId int references Artists(Id),
AlbumsId int references Albums(Id)
)

CREATE VIEW MusicInfo as
select m.Name as 'MusicName', m.TotalSecond, ar.Name as 'ArtistName', a.Name as 'AlbumName' from Musics m
left join Albums a
on m.AlbumsId=a.Id
left join Artists ar
on m.ArtistsId=ar.Id

CREATE VIEW AlbumInfo as
select A.Name as 'AlbumsName', Count(a.Name) as 'Say' from Musics m
left join Albums a
on m.AlbumsId=a.Id
group by a.Name

CREATE PROCEDURE usp_TuralSearch @ListenerCount int, @AlbumName nvarchar(50)
as
SELECT m.Name as 'MusicName', m.ListenerCount, a.Name as 'AlbumName' from Musics M
left join Albums a
on m.AlbumsId=a.Id
where @ListenerCount>m.ListenerCount and a.Name=@AlbumName

exec usp_TuralSearch 1, 'Salam'