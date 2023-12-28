AS	=	nasm

CC	=	gcc

RM	=	rm -f

ASFLAGS	=	-f elf64

NAME	=	libasm.so

INCLUDE_DIR = include/

SRCS_DIR	=	src/
SRCS_FILES	=	memcpy.asm			\
				memset.asm			\
				write.asm			\
				rindex.asm			\
				index.asm			\
				strcasecmp.asm		\
				strcmp.asm			\
				strlen.asm			\
				strncmp.asm			\
				strstr.asm

SRCS	=	$(addprefix $(SRCS_DIR), $(SRCS_FILES))

OBJS	=	$(SRCS:.asm=.o)

TESTS_NAME = test_runner

TESTS_DIR = tests/
TESTS_FILES = tests.c

TESTS = $(addprefix $(TESTS_DIR), $(TESTS_FILES))

UNITY_DIR = $(TESTS_DIR)/unity/src/
UNITY_FILES = unity.c
UNITY_SRCS = $(addprefix $(UNITY_DIR), $(UNITY_FILES))

all:		$(NAME)

$(NAME):	$(OBJS)
		$(CC) -nostdlib -shared -fPIC $(OBJS) -o $(NAME)

%.o : %.asm
		$(AS) $(ASFLAGS) -o $@ $<


test: $(OBJS) $(UNITY_SRCS)
		$(CC) -o $(TESTS_NAME) $(TESTS) $(UNITY_SRCS) $(OBJS) -I$(UNITY_DIR) -I$(INCLUDE_DIR)
		./$(TESTS_NAME)

clean:
		$(RM) $(OBJS)

fclean:		clean
		$(RM) $(NAME)

re:		fclean all

.PHONY:		all test clean fclean re
