// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require sortable-rails-jquery
//= require_tree .

$(document).ready(function() {
    var columns = $('.column').each(function() {
        console.log(this);
        options = {
            draggable: '.card',
            animation: 150,
	       onSort: function (/**Event*/evt) {
               var item = evt.item;
               console.log(evt.oldIndex);
               console.log(evt.newIndex);
               $.ajax({
                  url: '/drag',
                  type: 'put'
                });
           }
        };
        var sortable = Sortable.create(this, options);
    });
    // var sortable = Sortable.create(el);
})
