// Generated by CoffeeScript 1.6.3
(function() {
  var Crop, Shipment, expenses, land_available, land_max, land_owned, money, net, num_drivers, num_drivers_limit, num_drivers_max, num_farmers_limit, num_tillers, potato, profit, time_tilling, time_tilling_increase, time_tilling_max, timer_step, update_financial_text, update_industry_text, update_land, update_land_text, update_land_timing, update_money, update_profit, update_shipments, update_store, update_text, wage_driver, wage_farmer, wage_tiller;

  Crop = (function() {
    function Crop(name, val_seed, val_crop) {
      this.name = name;
      this.val_seed = val_seed;
      this.val_crop = val_crop;
      this.num_farmers = 0;
      this.num_acres = 0;
      this.num_harvested = 0;
      this.num_shipping = 0;
      this.time_harvest = 0;
      this.time_harvest_max = 0;
      this.time_shipping_max = 0;
    }

    Crop.prototype.update_crop_timing = function() {
      this.time_harvest_max = this.num_acres / (this.num_farmers * 0.2);
      this.time_harvest = (this.num_acres - this.num_harvested) / (this.num_farmers * 0.2);
      return this.time_shipping_max = 20 * Math.log(this.num_acres) * Math.LOG10E;
    };

    Crop.prototype.update_crop_text = function() {
      $("." + this.name + " #num_farmers").text(this.num_farmers);
      $("." + this.name + " #num_acres").text(this.num_acres);
      $("." + this.name + " #num_harvested").text(Math.floor(this.num_harvested));
      $("." + this.name + " #num_shipping").text(Math.floor(this.num_shipping));
      $("." + this.name + " #time_harvest").text("" + (Math.ceil(this.time_harvest)) + " (" + (Math.ceil(this.time_harvest_max)) + ") sec");
      return $("." + this.name + " #time_shipping").text("" + (Math.ceil(this.time_shipping_max)) + " sec");
    };

    Crop.prototype.update_crop = function() {
      this.num_harvested = Math.min(this.num_acres, this.num_harvested + this.num_farmers * 0.2);
      if (this.time_harvest > 0) {
        this.time_harvest--;
      }
      if (this.num_harvested >= this.num_acres && num_drivers > 0) {
        this.num_shipping += this.num_harvested;
        money -= this.val_seed * this.num_acres;
        num_drivers--;
        new Shipment(this, this.num_harvested, this.time_shipping_max);
        this.num_harvested = 0;
        return this.time_harvest = this.time_harvest_max;
      }
    };

    return Crop;

  })();

  num_farmers_limit = 5;

  potato = new Crop('potato', 0.50, 5);

  potato.num_farmers = 1;

  potato.num_acres = 10;

  potato.num_drivers_max = 1;

  potato.num_drivers = 1;

  potato.update_crop_timing();

  money = 50;

  profit = 60;

  expenses = 20;

  net = 40;

  wage_farmer = 6;

  wage_driver = 8;

  wage_tiller = 6;

  update_profit = function() {
    var time;
    time = Math.max(potato.time_harvest_max, potato.time_shipping_max);
    profit = potato.val_crop * potato.num_acres * 60 / time;
    expenses = potato.num_farmers * wage_farmer + num_drivers_max * wage_driver + +num_tillers * wage_tiller + potato.val_seed * potato.num_acres * 60 / time;
    return net = profit - expenses;
  };

  update_money = function() {
    return money -= (potato.num_farmers * wage_farmer + potato.num_drivers_max * wage_driver) / 60;
  };

  update_financial_text = function() {
    $('#money').text("$" + (money.toFixed(2)));
    $('#profit').text("$" + (profit.toFixed(2)) + "/min");
    $('#expenses').text("$" + (expenses.toFixed(2)) + "/min");
    return $('#net').text("$" + (net.toFixed(2)) + "/min");
  };

  $('#hire_farmer').button().click(function() {
    potato.num_farmers++;
    potato.update_crop_timing();
    update_profit();
    update_store();
    return update_text();
  });

  $('#fire_farmer').button().click(function() {
    potato.num_farmers--;
    potato.update_crop_timing();
    update_profit();
    update_store();
    return update_text();
  });

  $('#hire_driver').button().click(function() {
    num_drivers++;
    num_drivers_max++;
    update_profit();
    update_store();
    return update_text();
  });

  $('#fire_driver').button().click(function() {
    num_drivers--;
    num_drivers_max--;
    update_profit();
    update_store();
    return update_text();
  });

  $('#hire_tiller').button().click(function() {
    num_tillers++;
    update_land_timing();
    update_profit();
    update_store();
    return update_text();
  });

  $('#fire_tiller').button().click(function() {
    num_tillers--;
    update_land_timing();
    update_profit();
    update_store();
    return update_text();
  });

  update_store = function() {
    if (potato.num_farmers >= num_farmers_limit) {
      $('#hire_farmer').button("disable");
    } else {
      $('#hire_farmer').button("enable");
    }
    if (potato.num_farmers < 2) {
      $('#fire_farmer').button("disable");
    } else {
      $('#fire_farmer').button("enable");
    }
    if (num_drivers_max >= num_drivers_limit) {
      $('#hire_driver').button("disable");
    } else {
      $('#hire_driver').button("enable");
    }
    if (num_drivers < 2) {
      $('#fire_driver').button("disable");
    } else {
      $('#fire_driver').button("enable");
    }
    if (num_tillers < 1) {
      return $('#fire_tiller').button("disable");
    } else {
      return $('#fire_tiller').button("enable");
    }
  };

  $('#hire_farmer').button("enable");

  $('#hire_driver').button("enable");

  $('#hire_tiller').button("enable");

  $('#fire_farmer').button("disable");

  $('#fire_driver').button("disable");

  $('#fire_tiller').button("disable");

  land_available = 0;

  land_owned = 10;

  land_max = 30;

  num_tillers = 0;

  time_tilling = 0;

  time_tilling_max = 60;

  time_tilling_increase = 1.2;

  update_land_timing = function() {
    var percentage_tilled;
    if (num_tillers > 0) {
      percentage_tilled = time_tilling / time_tilling_max;
      time_tilling_max = Math.round(60 * Math.pow(time_tilling_increase, land_owned - 10) / num_tillers);
      return time_tilling = Math.round(time_tilling_max * percentage_tilled);
    }
  };

  update_land = function() {
    var num_drivers_limit;
    if (num_tillers > 0) {
      time_tilling++;
    }
    if (time_tilling >= time_tilling_max) {
      if (land_owned < land_max) {
        time_tilling -= time_tilling_max;
        land_owned++;
        potato.num_acres++;
        num_farmers_limit = Math.floor(land_owned / 2);
        num_drivers_limit = 2 * Math.log(land_owned) * Math.LOG10E;
        update_store();
        update_land_timing();
        update_profit();
        return update_text();
      } else {
        return time_tilling = time_tilling_max;
      }
    }
  };

  update_land_text = function() {
    $('#land_available').text("" + land_available + " acres");
    $('#land_owned').text("" + land_owned + "/" + land_max + " acres");
    $('#num_tillers').text(num_tillers);
    return $('#time_tilling').text("" + (time_tilling_max - time_tilling) + " (" + time_tilling_max + ") sec");
  };

  num_drivers = 1;

  num_drivers_max = 1;

  num_drivers_limit = 2;

  Shipment = (function() {
    function Shipment(crop, num_shipping, time_shipping) {
      this.crop = crop;
      this.num_shipping = num_shipping;
      this.time_shipping = time_shipping;
      Shipment.current.push(this);
    }

    Shipment.current = [];

    Shipment.prototype.remove = function(index) {
      num_drivers++;
      Shipment.current.splice(index, 1);
      this.crop.num_shipping -= this.num_shipping;
      return money += this.crop.val_crop * this.num_shipping;
    };

    return Shipment;

  })();

  update_shipments = function() {
    var i, _i, _len, _ref, _results;
    _ref = Shipment.current;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      i = _ref[_i];
      if (typeof i !== 'undefined') {
        if (i.time_shipping > 0) {
          _results.push(i.time_shipping--);
        } else {
          _results.push(i.remove(Shipment.current.indexOf(i)));
        }
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  update_industry_text = function() {
    return $("#num_drivers").text("" + num_drivers + "/" + num_drivers_max);
  };

  update_text = function() {
    update_financial_text();
    update_land_text();
    update_industry_text();
    return potato.update_crop_text();
  };

  timer_step = function() {
    potato.update_crop();
    update_money();
    update_land();
    update_shipments();
    return update_text();
  };

  update_text();

  $(document).ready(function() {
    return setInterval(timer_step, 1000);
  });

}).call(this);
