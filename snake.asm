.section .text
.globl start_game
.type start_game, @function

# start_game(len, n_apples)
# Parameters:
# - len: Length of the snake (passed in %rdi)
# - n_apples: Number of apples (passed in %rsi)

start_game:

    # Check if length of snake (%rdi) is less than 1
    cmp $1, %rdi
    jl snake_too_short
    # Check if length of snake (%rdi) is greater than 10
    cmp $10, %rdi
    jg snake_too_long

    # Check if number of apples (%rsi) is less than 1
    cmp $1, %rsi
    jl apples_too_few
    # Check if number of apples (%rsi) is greater than 5
    cmp $5, %rsi
    jg apples_too_many

    # Inputs are valid; proceed to the game loop
    jmp game_loop

snake_too_short:
    mov $1, %rax
    mov $1, %rdi
    lea message_too_short(%rip), %rsi
    mov $30, %rdx
    syscall                         # Print "Snake too short! Min length is 1."
    jmp end_game

snake_too_long:
    mov $1, %rax
    mov $1, %rdi
    lea message_too_long(%rip), %rsi
    mov $29, %rdx
    syscall                         # Print "Snake too long! Max length is 10."
    jmp end_game

apples_too_few:
    mov $1, %rax
    mov $1, %rdi
    lea message_too_few_apples(%rip), %rsi
    mov $30, %rdx
    syscall                         # Print "Not enough apples! Minimum is 1."
    jmp end_game

apples_too_many:
    mov $1, %rax
    mov $1, %rdi
    lea message_too_many_apples(%rip), %rsi
    mov $30, %rdx
    syscall                         # Print "Too many apples! Maximum is 5."
    jmp end_game

game_loop:
    mov $1, %rax
    mov $1, %rdi
    lea message_game_started(%rip), %rsi
    mov $22, %rdx
    syscall                         # Print "Game started successfully!"

end_game:
    # Print game end message
    mov $1, %rax
    mov $1, %rdi
    lea message_end(%rip), %rsi
    mov $23, %rdx
    syscall                         # Print "Game ending..."

    # Return from start_game
    ret

# Define messages for output
.section .data
message_start:
    .asciz "Start_game called successfully.\n"
message_too_short:
    .asciz "Snake too short! Min length is 1.\n"
message_too_long:
    .asciz "Snake too long! Max length is 10.\n"
message_too_few_apples:
    .asciz "Not enough apples! Minimum is 1.\n"
message_too_many_apples:
    .asciz "Too many apples! Maximum is 5.\n"
message_game_started:
    .asciz "Game started successfully!\n"
message_end:
    .asciz "Game ending...\n"
