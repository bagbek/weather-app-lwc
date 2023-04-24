/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-02-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
import { LightningElement } from "lwc";

export default class MwFooter extends LightningElement {
    get getCurrentYear() {
        return new Date().getFullYear();
    }
}
