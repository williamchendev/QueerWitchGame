/// @description Insert description here
// You can write your code in this editor

// Text Settings
text = "Pavallah Chutourmas. Vultusa dianmo horchek, sul capitalisma sogatas.";

font = fNormalFont;
font_color = c_white;

text_spd = 0.5;
text_read_timer_multiplier = 2.3;

text_separation = 0;
text_wrap_width = 160;

// Box Settings
box_breath_spd = 0.01;
box_breath_edge_clamp = 0.01;

box_horizontal_padding = 10;
box_vertical_padding = 6;

box_breath_padding = 4.5;

fade_spd = 0.15;

// Triangle Settings
triangle_angle = -15;
triangle_radius = 4;
triangle_offset = -2;

triangle_rotate_range = 30;

// Unit Settings
unit = instance_find(oUnit, 0);

// Cutscene Settings
input_advance = false;

// Vowel Settings
vowel_parsing = true;

vowels = noone;
vowels[0] = "a";
vowels[1] = "e";
vowels[2] = "i";
vowels[3] = "o";
vowels[4] = "u";

// Interrupt Settings
interrupt_text_active = true;
interrupt_text_chance = 1;
interrupt_text_y_offset = 8;
interrupt_text_read_timer_multiplier = 10;

interrupt_text[0] = "hh-";
interrupt_text[1] = "ffuck";
interrupt_text[2] = "-gck";
interrupt_text[3] = "-kch";
interrupt_text[4] = "hnnn";
interrupt_text[5] = "-hhah";
interrupt_text[6] = "n-no";
interrupt_text[7] = "pplease";
interrupt_text[8] = "ffuck";
interrupt_text[9] = "ah-";

// Text Box Variables
draw_val = random(1);

text_index = 0;
display_text = "";

font_contrast_color = c_white;

unit_draw_x = 0;
unit_draw_y = 0;

old_y = 0;

triangle_draw_angle = 0;
triangle_rotate_spd = 2;

destroy_timer = 0;
destroy_alpha = 1;
destroy = false;

game_manager = instance_find(oGameManager, 0);

// Debug
sprite_index = -1;