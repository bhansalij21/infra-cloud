#!/bin/bash

# Define log files
INIT_LOG="init_output.log"
PLAN_LOG="plan_output.log"
APPLY_LOG="apply_output.log"
DESTROY_LOG="destroy_output.log"

# Run tofu init and capture output
echo "Running tofu init..."
tofu init -no-color > $INIT_LOG 2>&1
echo "Output of 'tofu init' captured in $INIT_LOG"

# Run tofu plan and capture output
echo "Running tofu plan..."
tofu plan -out=tfplan -no-color > $PLAN_LOG 2>&1
echo "Output of 'tofu plan' captured in $PLAN_LOG"

# Run tofu apply and capture output
echo "Running tofu apply..."
tofu apply tfplan -no-color > $APPLY_LOG 2>&1
echo "Output of 'tofu apply' captured in $APPLY_LOG"

# Optional: Destroy infrastructure and capture output
# echo "Running tofu destroy..."
# tofu destroy -auto-approve -no-color > $DESTROY_LOG 2>&1
# echo "Output of 'tofu destroy' captured in $DESTROY_LOG"