# Data_SQL_programming

## Dataset Introduction
Dataset 명 1: Video Games Sales
Dataset 출처: https://www.kaggle.com/datasets/gregorut/videogamesales

Dataset 명 2: Videos Game Review
Dataset 출처: https://www.kaggle.com/datasets/arnabchaki/popular-video-games-1980-2023

## Purpose
다음 분기에는 어떤 게임을 설계해야 할까
- 지역에 따라 게임 장르의 선호도
- 연도별 게임 트렌드
- 출고량이 높은 게임에 대한 분석 및 시각화

## Dataset을 통하여 확인하고 싶은 내용
연도별 게임의 트렌드 -> 현재 트렌드에 맞는 장르를 선택
플랫폼 별 선호하는 게임의 장르 -> 어떠한 플랫폼의 게임을 출시할지 결정
선택한 플랫폼에서 지역별 출고량 조사 -> 어떤 지역에 홍보를 집중할 지 결정

## Table 설계
1. vgame_sales_rank - 전반적인 게임 정보를 가지고 있는 테이블
2. vgame_sales_region - 게임들의 각 지역별 출고량 정보를 가지고 있는 테이블
3. vgame_review_rating - 게임의 평점을 가지고 있는 테이블

4. ## 전체적인 구조
5. ![Untitled1](https://github.com/K-Kaos/SQL_Programming/assets/70849467/40966bed-1c2f-46c4-934a-8ad5cd655bfa)

## Conclusion
1. 스포츠, 액션, 슈팅 장르: 이 세 가지 장르의 게임들은 대체로 긍정적인 리뷰와 높은 평점을 받았으며, 이는 곧 높은 판매량의 결과로 이어졌습니다. 
⇒ 따라서 다음 분기에도 최근 10년간 높은 판매량을 보인 세 장르의 게임을 출시하는 것이 판매량을 높일 수 있는 좋은 전략일 것입니다.    
2. 전 세계적인 판매량을 고려하여 게임을 출시하는 것이 중요합니다. 지역을 타지 않고 꾸준히 높은 판매량을 기록했던 플랫폼은 PS(플레이스테이션), DS(닌텐도)입니다.
3. 각 플랫폼이 선호하는 장르를 참고하였을때, 
⇒ DS - 스포츠, 시뮬레이션 / PS - 스포츠, 전투, 액션 임을 확인할 수 있었습니다.    
4. 따라서 **다음 분기에 출시할 게임은 PS(플레이스테이션)나 DS(닌텐도) 플랫폼의 스포츠 장르 게임을 설계하는 것이 대체로 높은 판매량을 기록할 수 있을 것**입니다.
