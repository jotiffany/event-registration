// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require twitter/typeahead
//= require bootstrap-datepicker

var event_id = $('#guest_event').val();
var engine = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url: '/events/' + event_id + '/guests.json?query=%QUERY',
    filter: function (guests) {
      return $.map(guests, function (data) {
        return {
          name: data.name
        };
      });
    }
  }
});
engine.initialize();

// instantiate the typeahead UI
$('#registration-form #guest_name').typeahead(null, {
  displayKey: 'name',
  source: engine.ttAdapter()
});

$('[data-behaviour~=datepicker]').datepicker({
  format: 'yyyy-mm-dd'
});