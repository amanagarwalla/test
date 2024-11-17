.section .text
.globl _start
.type _start, @function

# Entry point for the program
_start:
    # Initialize snake length and apple count
    mov $5, %rdi        # Default snake length
    mov $3, %rsi        # Default apple count

    # Call the start_game function with default parameters
    call start_game

    # Exit the program gracefully
    mov $60, %rax       # Syscall number for exit
    xor %rdi, %rdi      # Exit code 0
    syscall             # Make the syscall
