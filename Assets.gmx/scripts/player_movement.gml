// Player Input
var move_right = keyboard_check(ord("D"));
var move_left = keyboard_check(ord("A"));
var move_crouch = keyboard_check(ord("S"));
var move_jump = keyboard_check_pressed(vk_space);
button_A = false;
button_B = false; 
button_X = false; 
button_Y = false;

if (gamepad_is_supported()){
    var padCount = gamepad_get_device_count();
    var pad = 0;
    if(padCount > pad){
        gamepad_is_connected(pad);
    }
    button_A = gamepad_button_check(pad, gp_face1);
    button_B = gamepad_button_check(pad, gp_face2);
    button_X = gamepad_button_check(pad, gp_face3);
    button_Y = gamepad_button_check(pad, gp_face4);
}

var collisionWall = collisionblock;

// React to inputs
move = 0;
if(move_left){
    move -= 1;
}
if(move_right){
    move += 1;
}
hsp = move * moveSpeed;
if (vsp < 10) {
    vsp += grav;
}

if (place_meeting(x, y+1, collisionWall)) 
{
    var j = jumpSpeed * -1;
    vsp = (move_jump * j);
}

var isMoving = hsp != 0 || vsp != 0;

if(isMoving) {

    var updateSprite = player_move;

    if(vsp > 0){
        updateSprite = player_fall;
    }

    if(vsp < 0){
        updateSprite = player_jump;
    }
    
    sprite_index = updateSprite;
    
    if(hsp > 0) {
        if(image_xscale < 0){
            image_xscale *= -1;       
        }
    }
    
    if(hsp < 0) {
        if(image_xscale > 0){
            image_xscale *= -1;       
        }
    }
}
else {
    sprite_index = player_idle;
}
    if(move_crouch){
        sprite_index = player_crouch;
    }

if(place_meeting(x+hsp, y, collisionWall)){
    while(!place_meeting(x + sign(hsp), y, collisionWall)) {
        x += sign(hsp);
    }
    hsp = 0;
}

if(place_meeting(x, y + vsp, collisionWall)){
    while(!place_meeting(x, y + sign(vsp), collisionWall)) {
        y += sign(vsp);
    }
    vsp = 0;
}

x += hsp;
y += vsp;
