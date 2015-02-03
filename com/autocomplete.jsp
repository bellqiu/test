<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
  <meta charset="utf-8">
  <title>jQuery UI Autocomplete - Combobox</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  <style>
  .custom-combobox {
    position: relative;
    display: inline-block;
  }
  .custom-combobox-toggle {
    position: absolute;
    top: 0;
    bottom: 0;
    margin-left: -1px;
    padding: 0;
  }
  .custom-combobox-input {
    margin: 0;
    padding: 5px 10px;
  }
  </style>
  <script>
  (function($) {
    $.widget("custom.combobox", {
      _create: function() {
        this.wrapper = $("<span>").addClass("custom-combobox" ).insertAfter(this.element);
        this.element.hide();
        this._createAutocomplete();
        this._createShowAllButton();
      },
 
      _createAutocomplete: function() {
        var selected = this.element.children(":selected"),
        value = selected.val() ? selected.text() : "";
 
        this.input = $("<input>").appendTo(this.wrapper).val(value)
          .attr( "title", "" )
          .addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
          .autocomplete({
            delay: 0,
            minLength: 0,
            source: $.proxy( this, "_source" )
          })
          .tooltip({
            tooltipClass: "ui-state-highlight"
          });
 
        this._on( this.input, {
          autocompleteselect: function( event, ui ) {
        	if(ui.item.option) {
        		// TODO add cascade for sub-combobox 
        		$(".child-combobox .custom-combobox-input").val("");
	            ui.item.option.selected = true;
	            this._trigger( "select", event, {
	              item: ui.item.option
	            });
        	} else {
        		// TODO do when sub-combobox change
        		this._trigger( "select", event, {
  	              item: ui.item
  	            });
        	}
          },
 
          autocompletechange: "_removeIfInvalid"
        });
      },
 
      _createShowAllButton: function() {
        var input = this.input,
          wasOpen = false;
        $( "<a>" )
          .attr( "tabIndex", -1 )
          .attr( "title", "Show All Items" )
          .tooltip()
          .appendTo( this.wrapper )
          .button({
            icons: {
              primary: "ui-icon-triangle-1-s"
            },
            text: false
          })
          .removeClass( "ui-corner-all" )
          .addClass( "custom-combobox-toggle ui-corner-right" )
          .mousedown(function() {
            wasOpen = input.autocomplete("widget").is(":visible");
          })
          .click(function() {
            input.focus();
 
            // Close if already visible
            if ( wasOpen ) {
              return;
            }
 
            // Pass empty string as value to search for, displaying all results
            input.autocomplete( "search", "" );
          });
      },
 
      _source: function( request, response ) {
        var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
        response( this.element.children( "option" ).map(function() {
          var text = $( this ).text();
          if ( this.value && ( !request.term || matcher.test(text) ) )
            return {
              label: text,
              value: text,
              option: this
            };
        }) );
      },
 
      _removeIfInvalid: function( event, ui ) {
 
        console.log(this.element.attr('id'));
        // Selected an item, nothing to do
        if ( ui.item ) {
        	console.log(ui.item);
          return;
        }
 
        // Search for a match (case-insensitive)
        var value = this.input.val(),
          valueLowerCase = value.toLowerCase(),
          valid = false;
        this.element.children( "option" ).each(function() {
          if ( $( this ).text().toLowerCase() === valueLowerCase ) {
            this.selected = valid = true;
            return false;
          }
        });
 
        // Found a match, nothing to do
        if ( valid ) {
          return;
        }
 
        // Remove invalid value
        this.input
          .val( "" )
          .attr( "title", value + " didn't match any item" )
          .tooltip( "open" );
        this.element.val( "" );
        this._delay(function() {
          this.input.tooltip( "close" ).attr( "title", "" );
        }, 2500 );
        this.input.autocomplete( "instance" ).term = "";
      },
 
      _destroy: function() {
        this.wrapper.remove();
        this.element.show();
      },
      
      _setOption: function(key, value) {
          //this.input.data("autocomplete")._setOption(key, value);
    	  this.input.autocomplete("instance")._setOption(key, value);
      }
    });
  })( jQuery );
 
  $(function() {
    $( "#combobox" ).combobox();
    $( "#sub-combobox" ).combobox();
    /* $( "#sub-combobox" ).autocomplete({ disabled: true} ); */
    $( "#sub-combobox" ).combobox("option", "source", ["Foo", "Bar"]);
    $( "#toggle" ).click(function() {
      $( "#combobox" ).toggle();
    });
    /* $("#sub-combobox").next("input").autocomplete("option", "source", ["Foo", "Bar"]); */
  });
  </script>
</head>
<body>
 
<div class="ui-widget parent-combobox">
  <label>Your preferred programming language: </label>
  <select id="combobox">
    <option value="">Select one...</option>
    <option data-id="1" value="ActionScript1">ActionScript</option>
    <option data-id="2" value="AppleScript">AppleScript</option>
    <option data-id="3" value="Asp">Asp</option>
    <option data-id="4" value="BASIC">BASIC</option>
    <option data-id="5" value="C">C</option>
    <option data-id="6" value="C++">C++</option>
    <option data-id="7" value="Clojure">Clojure</option>
    <option data-id="8" value="COBOL">COBOL</option>
    <option data-id="9" value="ColdFusion">ColdFusion</option>
    <option data-id="10" value="Erlang">Erlang</option>
    <option data-id="11" value="Fortran">Fortran</option>
    <option data-id="12" value="Groovy">Groovy</option>
    <option data-id="13" value="Haskell">Haskell</option>
    <option data-id="14" value="Java">Java</option>
    <option data-id="15" value="JavaScript">JavaScript</option>
    <option data-id="16" value="Lisp">Lisp</option>
    <option data-id="17" value="Perl">Perl</option>
    <option data-id="18" value="PHP">PHP</option>
    <option data-id="19" value="Python">Python</option>
    <option data-id="20" value="Ruby">Ruby</option>
    <option data-id="21" value="Scala">Scala</option>
    <option data-id="22" value="Scheme">Scheme</option>
    <option data-id="23" value="Scheme">我们aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</option>
    <option data-id="24" value="Scheme">适得其反</option>
    <option data-id="25" value="Scheme">其反</option>
  </select>
</div>
<div class="ui-widget child-combobox">
  <label>Your sub selections: </label>
  <select id="sub-combobox">
  	<option value="">Select one...</option>
  </select>
</div>
<button id="toggle">Show underlying select</button>
 
</body>
