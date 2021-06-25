// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

String country = "USA", code = "US";
Map<String, Country> data, countryData;
Map<String, Country> countryFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Country>(k, Country.fromJson(v)));

String countryToJson(Map<String, Country> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Country {
  Country({
    this.code,
    this.continent,
    this.location,
    this.lastUpdatedDate,
    this.totalCases,
    this.newCases,
    this.newCasesSmoothed,
    this.totalDeaths,
    this.newDeaths,
    this.newDeathsSmoothed,
    this.totalCasesPerMillion,
    this.newCasesPerMillion,
    this.newCasesSmoothedPerMillion,
    this.totalDeathsPerMillion,
    this.newDeathsPerMillion,
    this.newDeathsSmoothedPerMillion,
    this.reproductionRate,
    this.icuPatients,
    this.icuPatientsPerMillion,
    this.hospPatients,
    this.hospPatientsPerMillion,
    this.weeklyIcuAdmissions,
    this.weeklyIcuAdmissionsPerMillion,
    this.weeklyHospAdmissions,
    this.weeklyHospAdmissionsPerMillion,
    this.newTests,
    this.totalTests,
    this.totalTestsPerThousand,
    this.newTestsPerThousand,
    this.newTestsSmoothed,
    this.newTestsSmoothedPerThousand,
    this.positiveRate,
    this.testsPerCase,
    this.testsUnits,
    this.totalVaccinations,
    this.peopleVaccinated,
    this.peopleFullyVaccinated,
    this.newVaccinations,
    this.newVaccinationsSmoothed,
    this.totalVaccinationsPerHundred,
    this.peopleVaccinatedPerHundred,
    this.peopleFullyVaccinatedPerHundred,
    this.newVaccinationsSmoothedPerMillion,
    this.stringencyIndex,
    this.population,
    this.populationDensity,
    this.medianAge,
    this.aged65Older,
    this.aged70Older,
    this.gdpPerCapita,
    this.extremePoverty,
    this.cardiovascDeathRate,
    this.diabetesPrevalence,
    this.femaleSmokers,
    this.maleSmokers,
    this.handwashingFacilities,
    this.hospitalBedsPerThousand,
    this.lifeExpectancy,
    this.humanDevelopmentIndex,
  });
  String code;
  Continent continent;
  String location;
  DateTime lastUpdatedDate;
  double totalCases;
  double newCases;
  double newCasesSmoothed;
  double totalDeaths;
  double newDeaths;
  double newDeathsSmoothed;
  double totalCasesPerMillion;
  double newCasesPerMillion;
  double newCasesSmoothedPerMillion;
  double totalDeathsPerMillion;
  double newDeathsPerMillion;
  double newDeathsSmoothedPerMillion;
  double reproductionRate;
  double icuPatients;
  double icuPatientsPerMillion;
  double hospPatients;
  double hospPatientsPerMillion;
  double weeklyIcuAdmissions;
  double weeklyIcuAdmissionsPerMillion;
  double weeklyHospAdmissions;
  double weeklyHospAdmissionsPerMillion;
  double newTests;
  double totalTests;
  double totalTestsPerThousand;
  double newTestsPerThousand;
  double newTestsSmoothed;
  double newTestsSmoothedPerThousand;
  double positiveRate;
  double testsPerCase;
  TestsUnits testsUnits;
  double totalVaccinations;
  double peopleVaccinated;
  double peopleFullyVaccinated;
  double newVaccinations;
  double newVaccinationsSmoothed;
  double totalVaccinationsPerHundred;
  double peopleVaccinatedPerHundred;
  double peopleFullyVaccinatedPerHundred;
  double newVaccinationsSmoothedPerMillion;
  double stringencyIndex;
  double population;
  double populationDensity;
  double medianAge;
  double aged65Older;
  double aged70Older;
  double gdpPerCapita;
  double extremePoverty;
  double cardiovascDeathRate;
  double diabetesPrevalence;
  double femaleSmokers;
  double maleSmokers;
  double handwashingFacilities;
  double hospitalBedsPerThousand;
  double lifeExpectancy;
  double humanDevelopmentIndex;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        continent: json["continent"] == null
            ? null
            : continentValues.map[json["continent"]],
        location: json["location"],
        lastUpdatedDate: DateTime.parse(json["last_updated_date"]),
        totalCases: json["total_cases"] == null ? null : json["total_cases"],
        newCases: json["new_cases"] == null ? null : json["new_cases"],
        newCasesSmoothed: json["new_cases_smoothed"] == null
            ? null
            : json["new_cases_smoothed"].toDouble(),
        totalDeaths: json["total_deaths"] == null ? null : json["total_deaths"],
        newDeaths: json["new_deaths"] == null ? null : json["new_deaths"],
        newDeathsSmoothed: json["new_deaths_smoothed"] == null
            ? null
            : json["new_deaths_smoothed"].toDouble(),
        totalCasesPerMillion: json["total_cases_per_million"] == null
            ? null
            : json["total_cases_per_million"].toDouble(),
        newCasesPerMillion: json["new_cases_per_million"] == null
            ? null
            : json["new_cases_per_million"].toDouble(),
        newCasesSmoothedPerMillion:
            json["new_cases_smoothed_per_million"] == null
                ? null
                : json["new_cases_smoothed_per_million"].toDouble(),
        totalDeathsPerMillion: json["total_deaths_per_million"] == null
            ? null
            : json["total_deaths_per_million"].toDouble(),
        newDeathsPerMillion: json["new_deaths_per_million"] == null
            ? null
            : json["new_deaths_per_million"].toDouble(),
        newDeathsSmoothedPerMillion:
            json["new_deaths_smoothed_per_million"] == null
                ? null
                : json["new_deaths_smoothed_per_million"].toDouble(),
        reproductionRate: json["reproduction_rate"] == null
            ? null
            : json["reproduction_rate"].toDouble(),
        icuPatients: json["icu_patients"] == null ? null : json["icu_patients"],
        icuPatientsPerMillion: json["icu_patients_per_million"] == null
            ? null
            : json["icu_patients_per_million"].toDouble(),
        hospPatients:
            json["hosp_patients"] == null ? null : json["hosp_patients"],
        hospPatientsPerMillion: json["hosp_patients_per_million"] == null
            ? null
            : json["hosp_patients_per_million"].toDouble(),
        weeklyIcuAdmissions: json["weekly_icu_admissions"] == null
            ? null
            : json["weekly_icu_admissions"].toDouble(),
        weeklyIcuAdmissionsPerMillion:
            json["weekly_icu_admissions_per_million"] == null
                ? null
                : json["weekly_icu_admissions_per_million"].toDouble(),
        weeklyHospAdmissions: json["weekly_hosp_admissions"] == null
            ? null
            : json["weekly_hosp_admissions"].toDouble(),
        weeklyHospAdmissionsPerMillion:
            json["weekly_hosp_admissions_per_million"] == null
                ? null
                : json["weekly_hosp_admissions_per_million"].toDouble(),
        newTests: json["new_tests"] == null ? null : json["new_tests"],
        totalTests: json["total_tests"] == null ? null : json["total_tests"],
        totalTestsPerThousand: json["total_tests_per_thousand"] == null
            ? null
            : json["total_tests_per_thousand"].toDouble(),
        newTestsPerThousand: json["new_tests_per_thousand"] == null
            ? null
            : json["new_tests_per_thousand"].toDouble(),
        newTestsSmoothed: json["new_tests_smoothed"] == null
            ? null
            : json["new_tests_smoothed"],
        newTestsSmoothedPerThousand:
            json["new_tests_smoothed_per_thousand"] == null
                ? null
                : json["new_tests_smoothed_per_thousand"].toDouble(),
        positiveRate: json["positive_rate"] == null
            ? null
            : json["positive_rate"].toDouble(),
        testsPerCase: json["tests_per_case"] == null
            ? null
            : json["tests_per_case"].toDouble(),
        testsUnits: json["tests_units"] == null
            ? null
            : testsUnitsValues.map[json["tests_units"]],
        totalVaccinations: json["total_vaccinations"] == null
            ? null
            : json["total_vaccinations"],
        peopleVaccinated: json["people_vaccinated"] == null
            ? null
            : json["people_vaccinated"],
        peopleFullyVaccinated: json["people_fully_vaccinated"] == null
            ? null
            : json["people_fully_vaccinated"],
        newVaccinations:
            json["new_vaccinations"] == null ? null : json["new_vaccinations"],
        newVaccinationsSmoothed: json["new_vaccinations_smoothed"] == null
            ? null
            : json["new_vaccinations_smoothed"],
        totalVaccinationsPerHundred:
            json["total_vaccinations_per_hundred"] == null
                ? null
                : json["total_vaccinations_per_hundred"].toDouble(),
        peopleVaccinatedPerHundred:
            json["people_vaccinated_per_hundred"] == null
                ? null
                : json["people_vaccinated_per_hundred"].toDouble(),
        peopleFullyVaccinatedPerHundred:
            json["people_fully_vaccinated_per_hundred"] == null
                ? null
                : json["people_fully_vaccinated_per_hundred"].toDouble(),
        newVaccinationsSmoothedPerMillion:
            json["new_vaccinations_smoothed_per_million"] == null
                ? null
                : json["new_vaccinations_smoothed_per_million"],
        stringencyIndex: json["stringency_index"] == null
            ? null
            : json["stringency_index"].toDouble(),
        population: json["population"] == null ? null : json["population"],
        populationDensity: json["population_density"] == null
            ? null
            : json["population_density"].toDouble(),
        medianAge:
            json["median_age"] == null ? null : json["median_age"].toDouble(),
        aged65Older: json["aged_65_older"] == null
            ? null
            : json["aged_65_older"].toDouble(),
        aged70Older: json["aged_70_older"] == null
            ? null
            : json["aged_70_older"].toDouble(),
        gdpPerCapita: json["gdp_per_capita"] == null
            ? null
            : json["gdp_per_capita"].toDouble(),
        extremePoverty: json["extreme_poverty"] == null
            ? null
            : json["extreme_poverty"].toDouble(),
        cardiovascDeathRate: json["cardiovasc_death_rate"] == null
            ? null
            : json["cardiovasc_death_rate"].toDouble(),
        diabetesPrevalence: json["diabetes_prevalence"] == null
            ? null
            : json["diabetes_prevalence"].toDouble(),
        femaleSmokers: json["female_smokers"] == null
            ? null
            : json["female_smokers"].toDouble(),
        maleSmokers: json["male_smokers"] == null
            ? null
            : json["male_smokers"].toDouble(),
        handwashingFacilities: json["handwashing_facilities"] == null
            ? null
            : json["handwashing_facilities"].toDouble(),
        hospitalBedsPerThousand: json["hospital_beds_per_thousand"] == null
            ? null
            : json["hospital_beds_per_thousand"].toDouble(),
        lifeExpectancy: json["life_expectancy"] == null
            ? null
            : json["life_expectancy"].toDouble(),
        humanDevelopmentIndex: json["human_development_index"] == null
            ? null
            : json["human_development_index"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "continent":
            continent == null ? null : continentValues.reverse[continent],
        "location": location,
        "last_updated_date":
            "${lastUpdatedDate.year.toString().padLeft(4, '0')}-${lastUpdatedDate.month.toString().padLeft(2, '0')}-${lastUpdatedDate.day.toString().padLeft(2, '0')}",
        "total_cases": totalCases == null ? null : totalCases,
        "new_cases": newCases == null ? null : newCases,
        "new_cases_smoothed":
            newCasesSmoothed == null ? null : newCasesSmoothed,
        "total_deaths": totalDeaths == null ? null : totalDeaths,
        "new_deaths": newDeaths == null ? null : newDeaths,
        "new_deaths_smoothed":
            newDeathsSmoothed == null ? null : newDeathsSmoothed,
        "total_cases_per_million":
            totalCasesPerMillion == null ? null : totalCasesPerMillion,
        "new_cases_per_million":
            newCasesPerMillion == null ? null : newCasesPerMillion,
        "new_cases_smoothed_per_million": newCasesSmoothedPerMillion == null
            ? null
            : newCasesSmoothedPerMillion,
        "total_deaths_per_million":
            totalDeathsPerMillion == null ? null : totalDeathsPerMillion,
        "new_deaths_per_million":
            newDeathsPerMillion == null ? null : newDeathsPerMillion,
        "new_deaths_smoothed_per_million": newDeathsSmoothedPerMillion == null
            ? null
            : newDeathsSmoothedPerMillion,
        "reproduction_rate": reproductionRate == null ? null : reproductionRate,
        "icu_patients": icuPatients == null ? null : icuPatients,
        "icu_patients_per_million":
            icuPatientsPerMillion == null ? null : icuPatientsPerMillion,
        "hosp_patients": hospPatients == null ? null : hospPatients,
        "hosp_patients_per_million":
            hospPatientsPerMillion == null ? null : hospPatientsPerMillion,
        "weekly_icu_admissions":
            weeklyIcuAdmissions == null ? null : weeklyIcuAdmissions,
        "weekly_icu_admissions_per_million":
            weeklyIcuAdmissionsPerMillion == null
                ? null
                : weeklyIcuAdmissionsPerMillion,
        "weekly_hosp_admissions":
            weeklyHospAdmissions == null ? null : weeklyHospAdmissions,
        "weekly_hosp_admissions_per_million":
            weeklyHospAdmissionsPerMillion == null
                ? null
                : weeklyHospAdmissionsPerMillion,
        "new_tests": newTests == null ? null : newTests,
        "total_tests": totalTests == null ? null : totalTests,
        "total_tests_per_thousand":
            totalTestsPerThousand == null ? null : totalTestsPerThousand,
        "new_tests_per_thousand":
            newTestsPerThousand == null ? null : newTestsPerThousand,
        "new_tests_smoothed":
            newTestsSmoothed == null ? null : newTestsSmoothed,
        "new_tests_smoothed_per_thousand": newTestsSmoothedPerThousand == null
            ? null
            : newTestsSmoothedPerThousand,
        "positive_rate": positiveRate == null ? null : positiveRate,
        "tests_per_case": testsPerCase == null ? null : testsPerCase,
        "tests_units":
            testsUnits == null ? null : testsUnitsValues.reverse[testsUnits],
        "total_vaccinations":
            totalVaccinations == null ? null : totalVaccinations,
        "people_vaccinated": peopleVaccinated == null ? null : peopleVaccinated,
        "people_fully_vaccinated":
            peopleFullyVaccinated == null ? null : peopleFullyVaccinated,
        "new_vaccinations": newVaccinations == null ? null : newVaccinations,
        "new_vaccinations_smoothed":
            newVaccinationsSmoothed == null ? null : newVaccinationsSmoothed,
        "total_vaccinations_per_hundred": totalVaccinationsPerHundred == null
            ? null
            : totalVaccinationsPerHundred,
        "people_vaccinated_per_hundred": peopleVaccinatedPerHundred == null
            ? null
            : peopleVaccinatedPerHundred,
        "people_fully_vaccinated_per_hundred":
            peopleFullyVaccinatedPerHundred == null
                ? null
                : peopleFullyVaccinatedPerHundred,
        "new_vaccinations_smoothed_per_million":
            newVaccinationsSmoothedPerMillion == null
                ? null
                : newVaccinationsSmoothedPerMillion,
        "stringency_index": stringencyIndex == null ? null : stringencyIndex,
        "population": population == null ? null : population,
        "population_density":
            populationDensity == null ? null : populationDensity,
        "median_age": medianAge == null ? null : medianAge,
        "aged_65_older": aged65Older == null ? null : aged65Older,
        "aged_70_older": aged70Older == null ? null : aged70Older,
        "gdp_per_capita": gdpPerCapita == null ? null : gdpPerCapita,
        "extreme_poverty": extremePoverty == null ? null : extremePoverty,
        "cardiovasc_death_rate":
            cardiovascDeathRate == null ? null : cardiovascDeathRate,
        "diabetes_prevalence":
            diabetesPrevalence == null ? null : diabetesPrevalence,
        "female_smokers": femaleSmokers == null ? null : femaleSmokers,
        "male_smokers": maleSmokers == null ? null : maleSmokers,
        "handwashing_facilities":
            handwashingFacilities == null ? null : handwashingFacilities,
        "hospital_beds_per_thousand":
            hospitalBedsPerThousand == null ? null : hospitalBedsPerThousand,
        "life_expectancy": lifeExpectancy == null ? null : lifeExpectancy,
        "human_development_index":
            humanDevelopmentIndex == null ? null : humanDevelopmentIndex,
      };
}

enum Continent { ASIA, AFRICA, NORTH_AMERICA, EUROPE, SOUTH_AMERICA, OCEANIA }

final continentValues = EnumValues({
  "Africa": Continent.AFRICA,
  "Asia": Continent.ASIA,
  "Europe": Continent.EUROPE,
  "North America": Continent.NORTH_AMERICA,
  "Oceania": Continent.OCEANIA,
  "South America": Continent.SOUTH_AMERICA
});

enum TestsUnits {
  TESTS_PERFORMED,
  PEOPLE_TESTED,
  UNITS_UNCLEAR,
  SAMPLES_TESTED
}

final testsUnitsValues = EnumValues({
  "people tested": TestsUnits.PEOPLE_TESTED,
  "samples tested": TestsUnits.SAMPLES_TESTED,
  "tests performed": TestsUnits.TESTS_PERFORMED,
  "units unclear": TestsUnits.UNITS_UNCLEAR
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

String url =
    'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/latest/owid-covid-latest.json';
Future<Map<String, Country>> getDeets() async {
  final response = await http.get(Uri.parse(url));
  print(response.statusCode);
  return countryFromJson(response.body);
}
