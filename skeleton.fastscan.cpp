/* FASTSCAN */
inline static int scanint ()/*{{{*/
{
	char c;
	bool sign = false;
	int res = 0;

	do
		c = getchar();
	while (c != '-' && (c < '0' && '9' < c));
	
	if (c == '-')
		sign = true, c = getchar();
	while ('0' <= c && c <= '9')
		res = (res * 10) + (c - '0'), c = getchar();

	if (sign)
		res = -res;
	return res;
}

inline static long long scanlong ()
{
	char c;
	bool sign = false;
	long long res = 0LL;

	do
		c = getchar();
	while (c != '-' && (c < '0' && '9' < c));
	
	if (c == '-')
		sign = true, c = getchar();
	while ('0' <= c && c <= '9')
		res = (res * 10) + (c - '0'), c = getchar();

	if (sign)
		res = -res;
	return res;
}

inline static char* scanstring (int len)
{
	char *res = new char[len+1];
	char *ch = res;
	do 
		*ch = getchar();
	while (*ch == ' ' || *ch == '\n' || *ch == '\t');
	while (len--)
		*(ch++) = getchar();
	*ch = '0';
	return res;
}

inline static void printstring (char *ch, char end = '\n')
{
	while (*ch != '0')
		putchar(*(ch++));
	putchar(end);
}

inline static void printint (int x, char end = '\n')
{
	if (x == 0) {
		putchar('0');
		putchar(end);
		return;
	}
	if (x < 0) {
		putchar('-');
		x = -x;
	}

	char arr[10];
	unsigned short int i=0;
	while (x)
		arr[i++] = (x % 10) + '0', x /= 10;
	while (i)
		putchar(arr[--i]);
	putchar(end);
}

inline static void printlong (long long x, char end = '\n')
{
	if (x == 0LL) {
		putchar('0');
		putchar(end);
		return;
	}
	if (x < 0LL) {
		putchar('-');
		x = -x;
	}

	char arr[20];
	unsigned short int i=0;
	while (x)
		arr[i++] = (x % 10) + '0', x /= 10;
	while (i)
		putchar(arr[--i]);
	putchar(end);
}/*}}}*/
