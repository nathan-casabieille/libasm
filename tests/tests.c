#include "unity.h"
#include "libasm.h"
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

void setUp(void)
{
}

void tearDown(void)
{
}

void test_memcpy_basic(void)
{
    char src[10] = "123456789";
    char dest[10] = {0};
    
    _memcpy(dest, src, 9);
    TEST_ASSERT_EQUAL_MEMORY(dest, src, 9);
}

void test_memcpy_overlap(void)
{
    char src[10] = "123456789";
    
    _memcpy(src + 2, src, 5);
    TEST_ASSERT_EQUAL_MEMORY(src + 2, "12345", 5);
}

void test_memset_basic(void)
{
    char src[10];
    
    _memset(src, 'A', 9);
    for (int i = 0; i < 9; i++) {
        TEST_ASSERT_EQUAL(src[i], 'A');
    }
}

void test_write_basic(void)
{
    char *str = "Hello, World!";
    int size = strlen(str);
    int fd;
    char buffer[50];

    fd = open("/tmp/testfile.txt", O_WRONLY | O_CREAT, 0644);
    TEST_ASSERT_GREATER_THAN_INT(0, fd);

    int bytes_written = _write(fd, str, size);
    TEST_ASSERT_EQUAL(size, bytes_written);

    close(fd);

    fd = open("/tmp/testfile.txt", O_RDONLY);
    TEST_ASSERT_GREATER_THAN_INT(0, fd);

    int bytes_read = read(fd, buffer, sizeof(buffer));
    TEST_ASSERT_EQUAL(bytes_written, bytes_read);
    TEST_ASSERT_EQUAL_STRING_LEN(str, buffer, size);

    close(fd);
    remove("/tmp/testfile.txt");
}

void test_rindex_with_valid_character(void)
{
    const char *str = "Hello, World!";
    char c = 'o';
    char *result = _rindex(str, (int)c);
    TEST_ASSERT_NOT_NULL(result);
    TEST_ASSERT_EQUAL_PTR(result, &str[8]);
}

void test_rindex_with_invalid_character(void)
{
    const char *str = "Hello, World!";
    char c = 'z';
    char *result = _rindex(str, (int)c);
    TEST_ASSERT_NULL(result);
}

void test_rindex_with_empty_string(void)
{
    const char *str = "";
    char c = 'o';
    char *result = _rindex(str, (int)c);
    TEST_ASSERT_NULL(result);
}

void test_index_with_valid_character(void)
{
    const char *str = "Hello, World!";
    char c = 'o';
    char *result = _index(str, (int)c);
    TEST_ASSERT_NOT_NULL(result);
    TEST_ASSERT_EQUAL_PTR(result, &str[4]);
}

void test_index_with_invalid_character(void)
{
    const char *str = "Hello, World!";
    char c = 'z';
    char *result = _index(str, (int)c);
    TEST_ASSERT_NULL(result);
}

void test_index_with_empty_string(void)
{
    const char *str = "";
    char c = 'o';
    char *result = _index(str, (int)c);
    TEST_ASSERT_NULL(result);
}

void test_strcasecmp_equal(void)
{
    const char *str1 = "Hello";
    const char *str2 = "hello";
    int result = _strcasecmp(str1, str2);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strcasecmp_not_equal(void)
{
    const char *str1 = "Hello";
    const char *str2 = "World";
    int result = _strcasecmp(str1, str2);
    TEST_ASSERT_NOT_EQUAL(0, result);
}

void test_strcasecmp_mixed_case(void)
{ 
    const char *str1 = "AbCdEfG";
    const char *str2 = "aBcDeFg";
    int result = _strcasecmp(str1, str2);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strcasecmp_empty_strings(void)
{
    const char *str1 = "";
    const char *str2 = "";
    int result = _strcasecmp(str1, str2);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strcmp_equal_strings(void)
{
    const char *str1 = "Hello";
    const char *str2 = "Hello";
    int result = _strcmp(str1, str2);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strcmp_str1_greater(void)
{
    const char *str1 = "World";
    const char *str2 = "Hello";
    int result = _strcmp(str1, str2);
    TEST_ASSERT_TRUE(result > 0);
}

void test_strcmp_str2_greater(void)
{
    const char *str1 = "Hello";
    const char *str2 = "World";
    int result = _strcmp(str1, str2);
    TEST_ASSERT_TRUE(result < 0);
}

void test_strcmp_empty_strings(void)
{
    const char *str1 = "";
    const char *str2 = "";
    int result = _strcmp(str1, str2);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strlen_non_empty_string(void)
{
    const char *str = "Hello, World!";
    size_t result = _strlen(str);
    TEST_ASSERT_EQUAL_INT(13, result);
}

void test_strlen_empty_string(void)
{
    const char *str = "";
    size_t result = _strlen(str);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strlen_null_string(void)
{
    const char *str = NULL;
    size_t result = _strlen(str);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strncmp_equal_strings(void)
{
    const char *s1 = "Hello, World!";
    const char *s2 = "Hello, World!";
    int result = _strncmp(s1, s2, 13);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strncmp_different_strings(void)
{
    const char *s1 = "Hello, World!";
    const char *s2 = "Hello, Teeest!";
    int result = _strncmp(s1, s2, 6);
    TEST_ASSERT_EQUAL_INT(0, result);
}

void test_strncmp_limit_exceeded(void)
{
    const char *s1 = "Hello, World!";
    const char *s2 = "Hello, Teeeest!";
    int result = _strncmp(s1, s2, 13);
    TEST_ASSERT_EQUAL_INT(3, result);
}

void test_strstr_should_find_substring(void)
{
    const char *haystack = "Hello, World!";
    const char *needle = "World";
    char *result = strstr(haystack, needle);
    TEST_ASSERT_NOT_NULL(result);
    TEST_ASSERT_EQUAL_STRING("World!", result);
}

void test_strstr_should_return_null_when_needle_not_found(void)
{
    const char *haystack = "Hello, World!";
    const char *needle = "Goodbye";
    char *result = strstr(haystack, needle);
    TEST_ASSERT_NULL(result);
}

void test_strstr_should_return_haystack_when_needle_is_empty_string(void)
{
    const char *haystack = "Hello, World!";
    const char *needle = "";
    char *result = strstr(haystack, needle);
    TEST_ASSERT_EQUAL_STRING(haystack, result);
}

int main(void)
{
    UNITY_BEGIN();
    
    // _memcpy
    RUN_TEST(test_memcpy_basic);
    RUN_TEST(test_memcpy_overlap);
    RUN_TEST(test_memset_basic);

    // _write
    RUN_TEST(test_write_basic);

    // _rindex
    RUN_TEST(test_rindex_with_valid_character);
    RUN_TEST(test_rindex_with_invalid_character);
    RUN_TEST(test_rindex_with_empty_string);

    // _index
    RUN_TEST(test_index_with_valid_character);
    RUN_TEST(test_index_with_invalid_character);
    RUN_TEST(test_index_with_empty_string);

    // _strcasecmp
    RUN_TEST(test_strcasecmp_equal);
    RUN_TEST(test_strcasecmp_not_equal);
    RUN_TEST(test_strcasecmp_mixed_case);
    RUN_TEST(test_strcasecmp_empty_strings);

    // _strcmp
    RUN_TEST(test_strcmp_equal_strings);
    RUN_TEST(test_strcmp_str1_greater);
    RUN_TEST(test_strcmp_str2_greater);
    RUN_TEST(test_strcmp_empty_strings);

    // _strlen
    RUN_TEST(test_strlen_non_empty_string);
    RUN_TEST(test_strlen_empty_string);
    RUN_TEST(test_strlen_null_string);

    // strncmp
    RUN_TEST(test_strncmp_equal_strings);
    RUN_TEST(test_strncmp_different_strings);
    RUN_TEST(test_strncmp_limit_exceeded);

    // strstr
    RUN_TEST(test_strstr_should_find_substring);
    RUN_TEST(test_strstr_should_return_null_when_needle_not_found);
    RUN_TEST(test_strstr_should_return_haystack_when_needle_is_empty_string);

    return UNITY_END();
}
