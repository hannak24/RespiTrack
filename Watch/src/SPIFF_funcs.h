#ifndef __SPIFF_FUNCS_H__
#define __SPIFF_FUNCS_H__

int file_exists(char *);
void test_spiff();

void listDir(fs::FS &fs, const char *, uint8_t );
void appendFile(fs::FS &fs, const char *, const char *);
void readFile(fs::FS &fs, const char *);
void renameFile(fs::FS &fs, const char *, const char *);
void writeFile(fs::FS &fs, const char *, const char *);
void deleteFile(fs::FS &fs, const char *);
void testFileIO(fs::FS &fs, const char *);

#endif