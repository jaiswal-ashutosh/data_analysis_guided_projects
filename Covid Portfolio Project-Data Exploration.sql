
SET ANSI_WARNINGS OFF;
GO
select *
from PortfolioProject..covid_death
where continent is not null
order by 3,4
--select *
--from PortfolioProject..covid_vaccine
--order by 3,4

--Select data that are we using
select location, date, total_cases, new_cases,total_deaths, population
from PortfolioProject..covid_death
order by 1,2


--Looking at total cases vs total deaths
--shows liklihood of dying if you contract covid in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..covid_death
where location='India'
and continent is not null
order by 1,2


--Looking at total cases vs population
select location, date, total_cases,population, (total_cases/population)*100 as CasesPopulationPercentage
from PortfolioProject..covid_death
where location='India'
order by 1,2

--Looing at countries with highest infection rate compared to population
select location, population, max(total_cases) as HighestInfectionCount,max(total_cases/population)*100 as InfectedPopulationPercentage
from PortfolioProject..covid_death
--where location='India'
Group by location, population
order by InfectedPopulationPercentage desc

--showing countries with highest death count per population
select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..covid_death
--where location='India'
where continent is not null
group by location
order by TotalDeathCount desc


--Let's Break Things Down by Continent


select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..covid_death
--where location='India'
where continent is not null
group by continent
order by TotalDeathCount desc


--showing  continents with the highest death count per population

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..covid_death
--where location='India'
where continent is not null
group by continent
order by TotalDeathCount desc



--Global Numbers
select date, sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..covid_death
--where location='India'
where continent is not null
group by date
order by 1,2

select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..covid_death
--where location='India'
where continent is not null
--group by date
order by 1,2

--Looking at total population vs vaccination

select dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
, sum(convert(int,vc.new_vaccinations)) over (Partition by dt.location order by dt.location, dt.date)
from PortfolioProject..covid_death dt
join PortfolioProject..covid_vaccine vc
   on dt.location=vc.location
   and dt.date=vc.date
where dt.continent is not null
order by 2,3


--Use CTE

with PopvcVac(Continent,Location,Date,Population,New_Vaccinations,RollingPeopleVaccinated)
as
(select dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
, sum(convert(bigint,vc.new_vaccinations)) over (Partition by dt.location order by dt.location, dt.date) as RollingPeopleVaccinated
from PortfolioProject..covid_death dt
join PortfolioProject..covid_vaccine vc
   on dt.location=vc.location
   and dt.date=vc.date
where dt.continent is not null
--order by 2,3
)

select *,(RollingPeopleVaccinated/Population)*100
from PopvcVac




--Temp table
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)



Insert into #PercentPopulationVaccinated
select dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
, sum(convert(bigint,vc.new_vaccinations)) over (Partition by dt.location order by dt.location, dt.date) as RollingPeopleVaccinated
from PortfolioProject..covid_death dt
join PortfolioProject..covid_vaccine vc
   on dt.location=vc.location
   and dt.date=vc.date
--where dt.continent is not null
--order by 2,3

select *,(RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated



--Creating view to store data for later visualization

Create View PercentPopulationVaccinated as
select dt.continent, dt.location, dt.date, dt.population, vc.new_vaccinations
, sum(convert(bigint,vc.new_vaccinations)) over (Partition by dt.location order by dt.location, dt.date) as RollingPeopleVaccinated
from PortfolioProject..covid_death dt
join PortfolioProject..covid_vaccine vc
   on dt.location=vc.location
   and dt.date=vc.date
where dt.continent is not null
--order by 2,3


Select *
from PercentPopulationVaccinated
