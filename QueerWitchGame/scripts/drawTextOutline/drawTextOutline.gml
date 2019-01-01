/// drawTextOutline(x, y, text_color, outline_color, text);
/// @description Draws text with a pixel outline
/// @param {real} x The x coordinate to draw the text
/// @param {real} y The y coordinate to draw the text
/// @param {color} text_color The color to draw the text
/// @param {color} outline_color The color to draw the outline
/// @param {string} text The text to draw with the outline

// Assemble Variables
var temp_x = argument0;
var temp_y = argument1;

var temp_text_color = argument2;
var temp_outline_color = argument3;

var temp_text = argument4;

//Outline  
draw_set_color(temp_outline_color);  
draw_text(temp_x + 1, temp_y + 1, temp_text);  
draw_text(temp_x - 1, temp_y - 1, temp_text);  
draw_text(temp_x, temp_y + 1, temp_text);  
draw_text(temp_x + 1, temp_y, temp_text);  
draw_text(temp_x, temp_y - 1, temp_text);  
draw_text(temp_x - 1, temp_y, temp_text);  
draw_text(temp_x - 1, temp_y + 1, temp_text);  
draw_text(temp_x + 1, temp_y - 1, temp_text);  

//Text  
draw_set_color(temp_text_color);  
draw_text(temp_x, temp_y, temp_text);  