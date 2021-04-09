// http://rosettacode.org/wiki/Bitmap/Write_a_PPM_file#C
// kommandolinie progarm for linux,rpi osv :-)

// NB I har kun graatone i fielr derfor sætter jegrgb lig denne værdi for alle tre

//Jens
#include <stdlib.h>
#include <stdio.h>

char *inp = "/home/jdn/r";
int X=640;
int Y= 480;
int nrColours = 1;
char *outp ="/home/jdn/r2.bmp";

char *pI;

void rdRaw(char *fName, int x, int y)
{
FILE *p;
    int err;
    printf("\n s: %s - %i",fName,x*y);
    p = fopen(fName,"rb");

    if (p == NULL) {
    printf("\ncant open file");
        exit(0);
        }

    pI = (char *) malloc(x*y*nrColours*sizeof(int));

    printf("\nBEF READING...");
    err = fread(pI, 1,x*y,p);
    printf("\nerr. %i",err);

}


int main(void)
{
    const int dimx = X, dimy = Y;
    int i, j,k;

    rdRaw(inp,X,Y);
    FILE *fp = fopen(outp, "wb"); /* b - binary mode */

    fprintf(fp, "P6\n%d %d\n255\n", dimx, dimy);
    k = 0;
    for (j = 0; j < dimy; ++j) {
        for (i = 0; i < dimx; ++i) {
        //bruger graa som alle farver - hvis man havde rgb eller lignende sklulle man læse dem her
            fwrite((pI+k), 1, 1, fp);
            fwrite((pI+k), 1, 1, fp);
            fwrite((pI+k), 1, 1, fp);
            k++;
        }
    }
    fclose(fp);
    printf("\nok \n");
    return EXIT_SUCCESS;
}
