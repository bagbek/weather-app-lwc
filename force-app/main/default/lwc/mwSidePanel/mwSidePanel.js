/**
 * @description       : Side Panel Section contains the business logic of the components.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-14-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
import { LightningElement, wire } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";
import getWeatherForecast from "@salesforce/apex/MW_OpenWeatherOneCallController.getWeatherForecastService";
import getGeoLocations from "@salesforce/apex/MW_OpenWeatherOneCallController.getGeoLocationsService";
import CITY_IMAGE from "@salesforce/resourceUrl/MWAssets";
import { fireEvent } from "c/pubsub";

const WEATHER_ICONS = {
    "01d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/clear-day.svg`,
    "01n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/clear-night.svg`,
    "02d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day.svg`,
    "02n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-night.svg`,
    "03d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`,
    "03n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`,
    "04d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-day.svg`,
    "04n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-night.svg`,
    "09d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-day-drizzle.svg`,
    "09n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-night-drizzle.svg`,
    "10d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-day-rain.svg`,
    "10n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-night-rain.svg`,
    "11d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-day-extreme.svg`,
    "11n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-night-extreme.svg`,
    "13d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day-snow.svg`,
    "13n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-night-snow.svg`,
    "50d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/mist.svg`,
    "50n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/mist.svg`
};

export default class MwSidePanel extends LightningElement {
    // SVG Icons
    cloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`;
    rain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/rain.svg`;
    cityImage = `${CITY_IMAGE}/mw-assets/city2.jpeg`;

    // Side Panel Attributes
    currentTemperature;
    currentWeatherIcon;
    secondaryWeatherIcon;
    secondaryWeatherDescription;
    currentDateTime;
    currentDay;
    currentTime;
    cloudyPercentage;
    weatherDescription;
    oneHourRain;
    isDataAvailable = false;
    isOneHourRainForecastAvailable = false;
    locationQuery = "";
    geoLocationList;
    locationCountryFlagUrl = "";
    currentLocation = "Cebu City, Cebu"; // Set Default to Cebu City, PH

    // Search Attribute
    pickedLatitude = 10.317; // Set Default to Cebu City, PH latitude
    pickedLongitude = 123.891; // Set Default to Cebu City, PH longitude
    pickedLocationName;
    pickedCountry;
    pickedState;

    //longitude: 123.891,
    //latitude: 10.317,
    //unitType: "metric"

    /**
     * Wired method used for calling the getWeatherForecast
     * method from the MW_OpenWeatherOneCallController.
     * @param {*} param0
     */
    @wire(getWeatherForecast, {
        longitude: "$pickedLongitude",
        latitude: "$pickedLatitude",
        unitType: "metric"
    })
    getWeatherForecast({ error, data }) {
        if (data) {
            this.getSidePanelAttributes(data);
            this.getTodaysHighlightsAttribute(data);
            this.getWeekForecast(data);
        } else {
            if (error) {
                console.error(
                    "Error in MwSidePanel.getWeatherForecast() :",
                    error
                );
            }
        }
    }

    /**
     * Wired method used for calling the getGeoLocations
     * method from the MW_OpenWeatherOneCallController.
     * @param {String} param0
     */
    @wire(getGeoLocations, {
        query: "$locationQuery"
    })
    getGeoLocations({ error, data }) {
        if (data && data.length > 0) {
            let locationDropdown =
                this.template.querySelector(".location-dropdown");
            if (locationDropdown) {
                this.template.querySelector(".location-dropdown").className =
                    "slds-is-open";
            }
            const updatedGeoLocations = data.map((item) => ({
                ...item,
                flagURL:
                    `http://openweathermap.org/images/flags/${item.country}.png`.toLowerCase()
            }));
            this.geoLocationList = updatedGeoLocations;
        } else {
            if (error) {
                console.error(
                    "Error in MwSidePanel.getGeoLocations() :",
                    error
                );
            }
        }
    }

    /**
     * Method used for setting up the data needed for
     * side Panel.
     * @param {Object} response
     * @returns void
     */
    getSidePanelAttributes(response) {
        if (response == null) return;
        this.isDataAvailable = true;
        // this.currentLocation = "Build In-Progress";
        this.currentTemperature = Math.round(response.current.temp);
        this.getCurrentWeatherIcon(response.current.weather);
        this.currentDateTime = new Date(response.current.dt * 1000);
        this.cloudyPercentage = response.current.clouds;
        this.currentDay = this.currentDateTime.toLocaleString("en-us", {
            weekday: "long"
        });
        this.currentTime = this.currentDateTime.toLocaleString("en-US", {
            hour: "numeric",
            minute: "numeric",
            hour12: true
        });

        if (response.current.rain) {
            this.isOneHourRainForecastAvailable = true;
            this.oneHourRain = response.current.rain.oneHour;
        }
    }

    /**
     * Get the needed attribute for Week Forecast and
     * published using pubsub.
     * @param {Object} response
     * @returns void
     */
    getWeekForecast(response) {
        if (response == null) return;
        // Published an event
        fireEvent(this, "weekForecastEvt", {
            daily: response.daily
        });
    }

    /**
     * Get the needed attribute for todays highlights and
     * published using pubsub.
     * @param {Object} response
     * @returns void
     */
    getTodaysHighlightsAttribute(response) {
        if (response == null) return;
        // Published an event
        fireEvent(this, "todaysHighlightEvt", {
            uvi: response.current.uvi,
            wind_speed: response.current.wind_speed,
            wind_deg: response.current.wind_deg,
            sunrise: response.current.sunrise,
            sunset: response.current.sunset,
            humidity: response.current.humidity,
            visibility: response.current.visibility,
            dew_point: response.current.dew_point
        });
    }

    /**
     * Get the weather icon value from the response and
     * return the correct mapping of the custom weather icons
     * from the weatherIcons Object.
     * @param {Object} weather
     * @returns void
     */
    getCurrentWeatherIcon(weather) {
        if (weather == null) return;
        // Primary Weather Icon and Description
        this.weatherDescription = weather[0].description;
        this.currentWeatherIcon = JSON.parse(
            JSON.stringify(WEATHER_ICONS[weather[0].icon])
        );

        // Secondary Weather Icon and Description
        if (weather[1]) {
            this.secondaryWeatherDescription = weather[1].description;
            this.secondaryWeatherIcon = JSON.parse(
                JSON.stringify(WEATHER_ICONS[weather[1].icon])
            );
        }
    }

    /**
     * Method used for setting up the custom background style
     * of the current location panel.
     */
    get locationBackgroundStyle() {
        return `background-image: linear-gradient(
                rgba(0, 0, 0, 0.5), 
                rgba(0, 0, 0, 0.5)),
                url("${this.cityImage}"); 
                background-position: center; 
                background-repeat: no-repeat; 
                background-size: cover;`;
    }

    /**
     * Method handler for the Geo Location
     * onChange event.
     *
     * @param {Object} event
     */
    geoLocationValueOnChange(event) {
        this.locationQuery = event.target.value;
    }

    /**
     * Method event handler to get the Geo
     * Location attributes from the dropdown.
     * @param {Object} event
     */
    handleOnclickGeoLocation(event) {
        // Set to default values for location refresh
        this.isDataAvailable = false;
        this.isOneHourRainForecastAvailable = false;
        this.secondaryWeatherIcon = "";

        fireEvent(this, "changeLocationEvt", {
            isChanged: true
        });

        let locationName = event.target.closest("li").getAttribute("data-name");
        let locationCountry = event.target
            .closest("li")
            .getAttribute("data-country");
        let locationLatitude = event.target
            .closest("li")
            .getAttribute("data-latitude");
        let locationLongitude = event.target
            .closest("li")
            .getAttribute("data-longitude");
        let locationState = event.target
            .closest("li")
            .getAttribute("data-state");

        this.pickedLocationName = locationName;
        this.pickedCountry = locationCountry;
        this.pickedLatitude = locationLatitude;
        this.pickedLongitude = locationLongitude;
        this.currentLocation = `${this.pickedLocationName}, ${this.pickedCountry}`;
        this.pickedState = locationState;

        // Hide Dropdown
        this.template
            .querySelector(".location-dropdown")
            .classList.remove("slds-is-open");
    }
}
