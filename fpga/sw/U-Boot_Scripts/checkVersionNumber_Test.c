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

int main(int argc, char *argv[])
{
	int index;
	char* usrDefStr = "VIP_PROJECT_VERSION_NUMBER=";

	/* Check User Defined Field is Present */
	if (argc > 2 && strstr(argv[1], usrDefStr) && strstr(argv[2], usrDefStr))
	{
		char* startVersionNum1 = strchr(argv[1], '=');
		char* subVersionNum1 = strchr(argv[1], '.');
		int endVersionNum1 = strlen(argv[1]);
		char* startVersionNum2 = strchr(argv[2], '=');
		char* subVersionNum2 = strchr(argv[2], '.');
		int   endVersionNum2 = strlen(argv[2]);

		/* Version number must be in the format "..._NUMBER=MAJOR_NUM.SUB_NUM\0" */
		if (startVersionNum1 && subVersionNum1 && endVersionNum1
			&& ((int)(subVersionNum1 - startVersionNum1) > 0)
			&& startVersionNum2 && subVersionNum2 && endVersionNum2
			&& ((int)(subVersionNum2 - startVersionNum2) > 0))
		{
			/* Ensure that all characters passed into atof are valid character */
			
			for (index = 1; index < (endVersionNum1 - (int)(startVersionNum1 - argv[1]) - 1); index++) 
			{
				if (!isdigit(startVersionNum1[index]) || startVersionNum1[index] != '.')
				{
					puts("ERROR: Invalid characters within the param1 version string!!!"); 
					return 1;
				}
			}

			for (index = 1; index < (endVersionNum2 - (int)(startVersionNum2 - argv[2]) - 1); index++) 
			{
				if (!isdigit(startVersionNum2[index]) || startVersionNum2[index] != '.')
				{
					puts("ERROR: Invalid characters within the param2 version string!!!"); 
					return 1;
				}
				
			}

			/* Compare the two inputs to determine which one is "newer */
			double versionStr1 = atof(++startVersionNum1);
			double versionStr2 = atof(++startVersionNum2);
			if (versionStr1 && versionStr2 && versionStr1 < versionStr2) 
			{
				puts("Newer Version of Firmware Detected... Starting Update");
			} 
			else 
			{
				puts("The Newest Version of Firmware is already Present");
			}
		}
		else 
		{
			puts("ERROR: Unable to find all three identifier =,.,\\0 in the correct order!!!\n");
			return 1;
		}	
		
	} 
	else
	{
		puts("ERROR: Unable to find the user defined version field!!!\n");
		return 1;
	}

	return 0;
}
