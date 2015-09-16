function fillInCityKLADR() {
    var $container = $('.city_form');

    var $region = $container.find('input.region'),
        $city = $container.find('input.city'),
        $citycode = $container.find('input[type=hidden].city_code');

    var $tooltip = $container.find('.tooltip');
    $()
        .add($region)
        .add($city)
        .kladr({
            parentInput: $container.find('.js-form-address'),
            verify: true,
            select: function (obj) {
                setLabel($(this), obj.type);
                $tooltip.hide();

                if ($(this).data('kladr-type') == 'region') {
                    $city.kladr('controller').clear();
                    $city.val("");
                    $citycode.val("");
                }
                else if ($(this).data('kladr-type') == 'city') {
                    $citycode.val(obj.id);
                }
            },
            check: function (obj) {
                var $input = $(this);

                if (obj) {
                    setLabel($input, obj.type);
                    $tooltip.hide();
                }
                else {
                    showError($input, 'Введено неверно');
                }
            },
            checkBefore: function () {
                var $input = $(this);

                if (!$.trim($input.val())) {
                    $tooltip.hide();
                    return false;
                }
            },
            change: function (obj) {
            }
        });

    $region.kladr('type', $.kladr.type.region);
    $city.kladr('type', $.kladr.type.city);

    function setLabel($input, text) {
        text = text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();
        $input.parent().find('label').text(text);
    }

    function showError($input, message) {
        $tooltip.find('span').text(message);

        var inputOffset = $input.offset(),
            inputWidth = $input.outerWidth(),
            inputHeight = $input.outerHeight();

        var tooltipHeight = $tooltip.outerHeight();

        $tooltip.css({
            left: (inputOffset.left + inputWidth + 10) + 'px',
            top: (inputOffset.top + (inputHeight - tooltipHeight) / 2 - 1) + 'px'
        });

        $tooltip.show();
    }
}