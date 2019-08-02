/// @description Editor Text Input Init
// Creates the variables and settings for the text input box
// Users use this to put in text by clicking on it and typing on the keyboard

// Inherit from Parent
event_inherited();

// Settings
text_input = ""; // The Input Text

empty_text = ""; // Faded text to display when box is empty

width = 50; // Width of the Box
height = 13; // Height of the Box
font = fNormalFont; // Font of the text

text_limit = -1; // Caps string to a certain length (-1 for no cap)
use_alpha = true; // Use alphanumericals or just numbers

// Variables
text_show = 0; // The start index of the text_input substring to draw the displayed text
text_display = ""; // The text being displayed

line_timer = 0; // The timer that controls the flashes the text cursor has
select_index = 0; // The index of the cursor line for the text

clear = false;
reset = "";

cutoff = 4;

backspace_timer = 0;
backspace_mode = 0;

left_timer = 0;
left_mode = 0;

right_timer = 0;
right_mode = 0;