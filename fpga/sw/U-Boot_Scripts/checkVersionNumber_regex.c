/* 
 * Michael Capone, 3/25/2016
 *
 * This is a simple test script to determine which input argument is "newer".
 * Eventually, this script will be added into the U-Boot build, but for now,
 * this is a simple test application to verify that the core concept functions
 * as expected.
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <regex.h>

int main(int argc, char *argv[])
{
    regex_t versionRegex;
	
    if (!regcomp(&versionRegex, "VIP_PROJECT_VERSION_NUMBER=[[:digit:]]{1,5}\\.[[:digit:]]{1,5}",
	 REG_EXTENDED))
    {
        if (!regexec(&versionRegex, argv[1], 0, NULL, 0) 
		&& !regexec(&versionRegex, argv[2], 0, NULL, 0))
        {
           char* versionNumStr1 = strchr(argv[1], '=');
           double versionNum1 = atof(++versionNumStr1);
           char* versionNumStr2 = strchr(argv[2], '=');
           double versionNum2 = atof(++versionNumStr2);
           if (versionNum1 && versionNum2)
           {
                printf("Version Number 1: %.5f\n", versionNum1);
                printf("Version Number 2: %.5f\n", versionNum2);
		printf("Version Number %.5f is newer!\n",
		 (versionNum1 < versionNum2)? versionNum2: versionNum1);  	
           }
           else 
           {
                puts("ERROR: Unable to parse version number");
		regfree(&versionRegex);
                return 1;
           }
        }
        else 
        {
            puts("ERROR: Version formatting incorrect. Unable to find version identifier");
	    regfree(&versionRegex);
            return 1;
        }
    } 
    else 
    {
        puts("ERROR: Could not compile regex script");
        return 1;
    }
	/* Check User Defined Field is Present */ 
	regfree(&versionRegex);
	return 0;
}
