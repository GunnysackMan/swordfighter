    // Player Input
var move_right = keyboard_check(key_right);
var move_left = keyboard_check(key_left);
var move_jump = keyboard_check_pressed(key_jump);
var strike = keyboard_check_pressed(key_strike);

var players;
players[0] = obj_player01;
players[1] = obj_player02;

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

var collisionWall = obj_solid;

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
var facingLeft = hsp < 0;

if (place_meeting(x, y+1, collisionWall)) 
{
    var j = jumpSpeed * -1;
    vsp = (move_jump * j);
}

var isMoving = hsp != 0 || vsp != 0;

if(isMoving) {

    var updateSprite = sprite_move;

    if(vsp > 0){
        updateSprite = sprite_fall;
    }
    if(vsp < 0){ 
        updateSprite = sprite_jump;
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
    sprite_index = sprite_idle;
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

if(strike && strike_init == 0){
    weapon_strike = instance_create(x, y, obj_tempWeapon);
    weapon_strike.image_xscale = 1;
    strike_init = strike_duration;
}

x += hsp;
y += vsp;

if(strike_init > 0 && instance_exists(weapon_strike)){
    strike_init--;
    weapon_strike.image_xscale = image_xscale;
    weapon_strike.x = x;
    weapon_strike.y = y;
    
    for(var i = 0;i < players.length;i++){
        if(id != players[i].id){
            
        }
    }
    
    if(strike_init == 0 ){
        with weapon_strike {
            instance_destroy();
        }
    }
}