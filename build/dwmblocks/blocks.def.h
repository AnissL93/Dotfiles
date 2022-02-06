//Modify this file to change what commands output to your statusbar, and recompile using the make command.

static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

    // weather, update every 8 hours
	{"", "show_weather", 2*60*60*8, 1},

	{"INP: ", "input_method", 1, 2},

	// memory
	{"MEM: ", "show_resource", 200,	3},

	// battery
	{"BAT: ", "battery", 100, 0},

	// date
	{"", "d=$(date '+%b %d (%a) %I:%M%p'); echo $d",					120,		0},


	/* // network status */
	/* {"Net:", "", 5, 0}, */

	/* // cpu usage */
	/* {"", "", 5, 0}, */

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
