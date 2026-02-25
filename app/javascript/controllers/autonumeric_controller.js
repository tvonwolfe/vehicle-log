import { Controller } from "@hotwired/stimulus";
import AutoNumeric from "autonumeric";

export default class extends Controller {
  static values = {
    min: { type: Number, default: 0 },
    max: { type: Number, default: 999999.99 },
    currency: { type: String, default: "" },
    default: { type: Number, default: 0 },
    decimalPlaces: { type: Number, default: 0 }
  };

  connect() {
    const autoNumericOptions = {
      decimalCharacter: ".",
      decimalPlaces: this.decimalPlacesValue,
      defaultValueOverride: this.defaultValue,
      digitGroupSeparator: ",",
      minimumValue: this.minValue,
      maximumValue: this.maxValue,
      unformatOnSubmit: true,
      currencySymbol: this.currencyValue,
      currencySymbolPlacement: "p", // 'p' for prefix
      modifyValueOnWheel: true,
    };

    new AutoNumeric(this.element, autoNumericOptions);
  }
}
