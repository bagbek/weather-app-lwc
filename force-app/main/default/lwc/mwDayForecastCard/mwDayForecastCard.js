/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-07-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
import { LightningElement, api } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";

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

export default class MwDayForecast extends LightningElement {
    thunderstormsDayRain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-day-rain.svg`;

    // Main Attributes
    @api index;
    @api dailyForecast;
    weatherIcon;
    dayTemp;
    dayName;
    nightTemp;
    isActive;

    renderedCallback() {
        let dateTime = new Date(this.dailyForecast.dt * 1000);
        this.dayName = dateTime.toLocaleString("en-us", {
            weekday: "short"
        });
        this.weatherIcon = JSON.parse(
            JSON.stringify(WEATHER_ICONS[this.dailyForecast.weather[0].icon])
        );
        this.dayTemp = Math.round(this.dailyForecast.temp.day);
        this.nightTemp = Math.round(this.dailyForecast.temp.night);
        this.isActive = this.index === 0 ? true : false;
    }
}
