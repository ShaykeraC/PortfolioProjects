/*Covid 19 Exploration

Skills used: Joins, CTE's, Temp Tables, Window Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

select * 
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4;

--Select Data that we are going to start with

Select Location, Date, Total_cases, New_cases, Total_deaths, Population 
from CovidDeaths 
where Continent is not null
order by 1,2;

--total cases vs total deaths
--shows likelihood of dying if you contract covid in your country

Select Location, Date, Total_cases, Total_deaths, (Total_deaths/Total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%Bahamas%'
order by 1,2;


--total cases vs population
--shows what percentage of population infected with covid

Select Location, Date, Total_cases, Population, (Total_deaths/Population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
where location like '%Bahamas%'
order by 1,2


--Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX (Total_cases) as HighestInfectionCount, MAX((Total_deaths/Population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%Bahamas%'
group by continent, Location, Population
order by PercentPopulationInfected desc

--Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%Bahamas%'
where continent is not null
group by continent, Location
order by TotalDeathCount desc


--BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%Bahamas%'
where continent is not null
group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%Bahamas%'
where continent is not null 
--Group By date
order by 1,2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3