//
// Created by Dimitar Anastassov on 29.09.26.
//
#include "ir.h"

int main(void) {
    IrProgram *p = ir_program_new();

    /* 2 + 3 * 4 */
    Operand m = ir_binop(p, IR_MUL, ir_imm(3), ir_imm(4));
    Operand a = ir_binop(p, IR_ADD, ir_imm(2), m);
    ir_print_val(p, a);

    /* (2 + 3) * -4 + 10 */
    Operand s = ir_binop(p, IR_ADD, ir_imm(2), ir_imm(3));
    Operand n = ir_neg(p, ir_imm(4));
    Operand x = ir_binop(p, IR_MUL, s, n);
    Operand y = ir_binop(p, IR_ADD, x, ir_imm(10));
    ir_print_val(p, y);

    ir_print(p, stdout);
    ir_program_free(p);
    return 0;
}

