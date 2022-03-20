var $ = require("../jquery-3.6.0.js");

var themes = [
  {'theme': 'default-screen', 'text': '适合代码'},
  {'theme': 'narrow-screen', 'text': '窄屏模式'},
  {'theme': 'wide-screen', 'text': '宽屏模式'}
];
var currentTheme = 'wide-screen';

let PageTheme = function () {
  this.init();
};

PageTheme.prototype.init = function() {
  this.bindEvt();
};

PageTheme.prototype.bindEvt = function() {
  var $options = $.map(themes, function(item) {
    var selected = currentTheme === item.theme ? ' selected' : '';
    return '<option value="' + item.theme + '"' + selected + '>' + item.text +'</option>';
  });
  $('.page-theme').html($options);
  $('.page-theme').on('change', function() {
    var val = $(this).val();
    $("#pageThemeId").attr('href', './pageThemes/' + val + '.css');
  }).trigger('change');
};


module.exports = PageTheme;
