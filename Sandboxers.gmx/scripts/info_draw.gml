var spacing = 14;
var v_loc = 0;
var infoEnalbed = true;
if(infoEnalbed) {
    v_loc += spacing;
    var padCount = gamepad_get_device_count();
    var gamePadSupported = gamepad_is_supported();
    draw_text(10, v_loc, padCount);
    v_loc += spacing;
    draw_text(10, v_loc, gamePadSupported);
    for(var i = 0; i < padCount; i++) {
        v_loc += spacing;
        draw_text(10, v_loc + spacing, gamepad_is_connected(i));
    }
    
    for(var i = 0; i < padCount; i++) {
        v_loc += spacing;
        draw_text(10, v_loc + spacing, gamepad_button_check(i, gp_face1));
    }
}