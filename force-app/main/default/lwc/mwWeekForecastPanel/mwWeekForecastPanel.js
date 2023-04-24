/**
 * @description       : Week Forecast Panel Business logic.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-08-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
import { LightningElement } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";
import { registerListener, unregisterListener } from "c/pubsub";

export default class MwWeekForecastPanel extends LightningElement {
    // TODO: Remove after integration in week forecast
    partlyCloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day.svg`;
    cloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`;
    rain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/rain.svg`;
    thunderstormsDayRain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-day-rain.svg`;

    // Main Attributes
    weekForecast;

    connectedCallback() {
        // Subscribe todaysHighlightEvt
        registerListener("weekForecastEvt", this.handleWeekForecastEvt, this);

        // Subscribe to changeLocationEvt
        registerListener(
            "changeLocationEvt",
            this.handleChangeLocationEvt,
            this
        );
    }

    disconnectedCallback() {
        // Unsubscribe todaysHighlightEvt
        unregisterListener("weekForecastEvt", this.handleWeekForecastEvt, this);

        // Unsubscribe to changeLocationEvt
        unregisterListener(
            "changeLocationEvt",
            this.handleChangeLocationEvt,
            this
        );
    }

    /**
     * Subscriber function for the 'changeLocationEvt' which
     * contains the attribute for location onchange.
     * @param {Object} payload
     */
    handleChangeLocationEvt(payload) {
        if (payload == null) return;
        let locationIsChanged = payload.isChanged;
        if (locationIsChanged) {
            this.weekForecast = null;
        }
    }

    /**
     * Subscriber function for the 'weekForecastEvt' which
     * contains the week forecast attributes.
     * @param {Object} payload
     */
    handleWeekForecastEvt(payload) {
        if (payload == null) return;
        this.weekForecast = payload.daily;
    }
}
