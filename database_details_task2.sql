
-- Q 2.1

use project;

# Identify the top 5 countries with the highest green index scores and their respective carbon emissions

SELECT 
  g.country_id,
  g.green_index,
  c.carbon_emissions
FROM 
  green_totalscores AS g
JOIN 
  carbon_emissions AS c ON g.country_id = c.country_id
ORDER BY 
  g.green_index DESC
LIMIT 5;


# Assess the impact of renewable energy on the energy transition score across continents

SELECT 
  cl.continent,
  AVG(et.renewable_energy) AS avg_renewable_energy,
  AVG(et.renewable_contribution) AS avg_renewable_contribution
FROM 
  energy_transition AS et
JOIN 
  continent_list AS cl ON et.country_id = cl.country_id
GROUP BY 
  cl.continent;
  
# Evaluate the relationship between population size and green society measures

SELECT 
  pi.country,
  pi.population_2021,
  gs.green_buildings + gs.recycling_efforts + gs.forestation_change AS green_society_score
FROM 
  population_index AS pi
JOIN 
  green_society AS gs ON pi.country = gs.country_id
ORDER BY pi.population_2021 DESC;

# Query to combine climate policy efforts with population data

SELECT pi.country, cp.climate_action, cp.carbon_pricing, pi.population_2021
FROM climate_policy cp
JOIN population_index pi ON cp.country_id = pi.country
WHERE cp.climate_action > (SELECT AVG(climate_action) FROM climate_policy)
AND pi.population_2021 > (SELECT AVG(population_2021) FROM population_index)
ORDER BY cp.climate_action DESC, pi.population_2021 DESC;
