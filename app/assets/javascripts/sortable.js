//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require sortable-rails-jquery

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
                  url: window.location.pathname + '/sort',
                  type: 'post',
                  data: {oldIndex: evt.oldIndex, newIndex: evt.newIndex}
                });
           }
        };
        var sortable = Sortable.create(this, options);
    });
    // var sortable = Sortable.create(el);
})
