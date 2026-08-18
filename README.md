# 🎬 Netflix Movies & TV Shows SQL Analysis

## 📌 Project Overview
This project performs an end-to-end exploratory data analysis (EDA) on Netflix's movies and TV shows library using PostgreSQL. By linking dataset metadata on content titles, release details, genres, ratings, and cast members, this project answers key content performance and talent distribution business questions.

---

## 📊 Dataset Overview
The dataset consists of two core tables:
* **`titles.csv`** (5,850 rows): Metadata on movies and shows including IMDb/TMDB scores, runtime, age certification, release year, and genres.
* **`credits.csv`** (77,801 rows): Cast and crew records detailing actors, directors, characters, and associated title IDs.

---

## 🗄️ Database Schema & Setup

### 1. Table Definitions
```sql
CREATE TABLE credits (
    person_id   INT NOT NULL,
    id          VARCHAR(20) NOT NULL,
    name        VARCHAR(255) NOT NULL,
    character   VARCHAR(500),
    role        VARCHAR(50) NOT NULL
);

CREATE TABLE titles (
    id                    VARCHAR(20) PRIMARY KEY,
    title                 VARCHAR(255),
    type                  VARCHAR(10) NOT NULL,
    description           TEXT,
    release_year          SMALLINT NOT NULL,
    age_certification     VARCHAR(10),
    runtime               SMALLINT NOT NULL,
    genres                VARCHAR(255),
    production_countries  VARCHAR(100),
    seasons               NUMERIC(4, 1),
    imdb_id               VARCHAR(20),
    imdb_score            NUMERIC(3, 1),
    imdb_votes            NUMERIC(12, 1),
    tmdb_popularity       NUMERIC(10, 4),
    tmdb_score            NUMERIC(4, 2)
);

##  🗄️ Data Loading
```sql

COPY public.credits FROM '/path/to/credits.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ESCAPE '\');
COPY public.titles FROM '/path/to/titles.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ESCAPE '\');

##  🔍 Key Business Questions Answered

   - What are the top and bottom 10 movies and TV shows by IMDb rating?

   - How do average IMDb and TMDB scores compare across content types, countries, and age ratings?

   - How has content production volume grown by decade since 1940?

   - Who are the top 20 most frequent actors and directors on Netflix?

   - Which actors played the same character across multiple distinct titles?
