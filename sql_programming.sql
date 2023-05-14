show databases;
use vgame;
show tables;

-- csv 불러온 파일
select * from vgame_sales;
select * from vgame_review;

-- 전체 데이터셋 갯수 확인
SELECT COUNT(*) FROM vgame_sales; -- 11358
SELECT COUNT(*) FROM vgame_review; -- 1497

-- 코드 재시작 시, 테이블 DROP -> CREATE
DROP TABLE GAME;
DROP TABLE Publisher;
DROP TABLE Genre;
DROP TABLE GamePlatform;
DROP TABLE vgame_sales_rank;
DROP TABLE vgame_sales_region;
DROP TABLE vgame_review_rating;

-- 테이블 설계 1
-- Game Table 생성
CREATE TABLE Game (
  Id INT NOT NULL AUTO_INCREMENT,
  Year double,
  Genre text,
  Publisher text,
  Platform text,
  PRIMARY KEY (Id)
);

-- Game Table 값 넣기
INSERT INTO Game (Year, Genre, Publisher, Platform)
SELECT Year, Genre, Publisher, Platform
FROM vgame_sales;

-- Publisher 테이블 생성
CREATE TABLE Publisher (
  ID INT NOT NULL AUTO_INCREMENT,
  Publisher TEXT,
  PRIMARY KEY (ID)
);

-- Publisher Table 값 넣기
INSERT INTO Publisher (Publisher)
SELECT DISTINCT Publisher FROM vgame_sales;

-- Genre 테이블 생성
CREATE TABLE Genre (
  ID INT NOT NULL AUTO_INCREMENT,
  Genre TEXT,
  PRIMARY KEY (ID)
);

-- Genre Table 값 넣기
INSERT INTO Genre (Genre)
SELECT DISTINCT Genre FROM vgame_sales;

-- GamePlatform 테이블 생성
CREATE TABLE GamePlatform (
  ID INT NOT NULL AUTO_INCREMENT,
  Platform TEXT,
  PRIMARY KEY (ID)
);

-- GamePlatform Table 값 넣기
INSERT INTO GamePlatform (Platform)
SELECT DISTINCT Platform FROM vgame_sales;

-- 테이블 설계 2
-- vgame_sales_rank Table 생성
CREATE TABLE vgame_sales_rank (
  Id INT NOT NULL AUTO_INCREMENT,
  Name text,
  Platform text,
  Year double,
  Genre text,
  Publisher text,
  PRIMARY KEY (Id)
);

-- vgame_sales_rank Table 값 넣기
INSERT INTO vgame_sales_rank (Name, Platform, Year, Genre, Publisher)
SELECT Name, Platform, Year, Genre, Publisher
FROM vgame_sales;

-- vgame_sales_region Table 생성
CREATE TABLE vgame_sales_region(
  Id INT NOT NULL AUTO_INCREMENT,
  Name text,
  NA_Sales double,
  EU_Sales double,
  JP_Sales double,
  Other_Sales double,
  Global_Sales double,
  PRIMARY KEY (Id)
);

-- vgame_sales_region Table 값 넣기
INSERT INTO vgame_sales_region (Name, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales)
SELECT Name, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales
FROM vgame_sales;

-- vgame_review_rating Table 생성
CREATE TABLE vgame_review_rating(
  Id INT NOT NULL AUTO_INCREMENT,
  Name text,
  Rating long, 
  PRIMARY KEY (Id)
);

-- vgame_review_rating Table 값 넣기
INSERT INTO vgame_review_rating (Name, Rating)
SELECT Name, Rating
FROM vgame_review;

-- 컬럼의 속성값 찾기
SELECT COLUMN_NAME, COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vgame_sales';

-- 연도별 게임 트렌드 조회
SELECT 
    Year, 
    Genre, 
    Publisher, 
    SUM(Global_Sales) AS Total_Sales 
FROM 
    vgame_sales_rank 
JOIN 
	vgame_sales_region on vgame_sales_rank.id = vgame_sales_region.id
GROUP BY 
    Year, 
    Genre, 
    Publisher 
ORDER BY 
    Year, 
    Total_Sales DESC;
    
-- 플랫폼별 선호하는 게임 장르
SELECT 
    Platform, 
    Year,
    Genre, 
    SUM(Global_Sales) AS Total_Sales 
FROM 
    vgame_sales_rank 
JOIN 
	vgame_sales_region on vgame_sales_rank.id = vgame_sales_region.id
GROUP BY 
    Platform, 
    Year,
    Genre 
ORDER BY 
    Platform, 
    Year,
    Total_Sales DESC;
    
-- 플랫폼별 지역 출고량 조회
SELECT 
    Platform, 
    SUM(NA_Sales) AS NA_Sales, 
    SUM(EU_Sales) AS EU_Sales, 
    SUM(JP_Sales) AS JP_Sales, 
    SUM(Other_Sales) AS Other_Sales, 
    SUM(Global_Sales) AS Total_Sales 
FROM 
    vgame_sales_rank 
JOIN 
	vgame_sales_region on vgame_sales_rank.id = vgame_sales_region.id
GROUP BY 
    Platform 
ORDER BY 
    Total_Sales DESC;

-- 평점과 출고량의 상관관계
SELECT 
    vgame_sales_region.Name, 
    vgame_review_rating.Rating,
    SUM(vgame_sales_region.NA_Sales) AS Total_NA_Sales, 
    SUM(vgame_sales_region.EU_Sales) AS Total_EU_Sales, 
    SUM(vgame_sales_region.JP_Sales) AS Total_JP_Sales, 
    SUM(vgame_sales_region.Other_Sales) AS Total_Other_Sales, 
    SUM(vgame_sales_region.Global_Sales) AS Total_Global_Sales 
FROM 
    vgame_sales_region
INNER JOIN 
    vgame_review_rating ON vgame_sales_region.Name = vgame_review_rating.Name
GROUP BY 
    vgame_sales_region.Name, vgame_review_rating.Rating
ORDER BY
   Rating DESC;
   