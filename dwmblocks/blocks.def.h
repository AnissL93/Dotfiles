//Modify this file to change what commands output to your statusbar, and recompile using the make command.

static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{"", "__f=$(fcitx-remote); [ $__f = 2 ] && echo [CH]; [ $__f = 2 ] || echo [en]", 1, 0},

	// memory
	{"", "echo \"[M $(free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g) ]\"",	200,		0},

	// battery
	{"", "battery", 100, 0 },

	// date
	{"", "d=$(date '+%b %d (%a) %I:%M%p'); echo [$d]",					10,		0},


	// input methods
	/* {"", "", 5, 0}, */

	/* // network status */
	/* {"Net:", "", 5, 0}, */

	/* // cpu usage */
	/* {"", "", 5, 0}, */

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 5;
