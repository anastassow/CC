//
// Created by Dimitar Anastassov on 29.09.26.
//

#ifndef CC_LOWER_H
#define CC_LOWER_H

#include "ast.h"
#include "ir.h"

Operand lower_expr(IrProgram* p, const Node* n);

#endif //CC_LOWER_H
