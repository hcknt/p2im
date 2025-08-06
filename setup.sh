#!/bin/bash

declare -A firmware_info=(
    # ["CNC"]="STM32F429I-Discovery STM32F429ZI"
    # ["Console"]="FRDM-K64F MK64FN1M0VLL12"
    # ["Drone"]="NUCLEO-F103RB STM32F103RB"
    # ["Gateway"]="NUCLEO-F103RB STM32F103RB"
    # ["Heat_Press"]="Arduino-Due SAM3X8E"
    # ["PLC"]="STM32F429I-Discovery STM32F429ZI"
    # ["Reflow_Oven"]="NUCLEO-F103RB STM32F103RB"
    # ["Robot"]="NUCLEO-F103RB STM32F103RB"
    # ["Steering_Control"]="Arduino-Due SAM3X8E"
    ["3Dprinter"]="STM32F103RE STM32F103RE"
    ["LiteOS_IoT"]="STM32L431 STM32L431"
    ["Zepyhr_SocketCan"]="STM32L432KC STM32L432KC"
    ["XML_Parser"]="STM32L152XE STM32L152XE"
    ["utasker_MODBUS"]="STM32F429ZIT6U STM32F429ZIT6U"
    ["utasker_USB"]="STM32F429ZIT6U STM32F429ZIT6U"
)

REPO_PATH="/p2im"
GCC_ARM_PATH="$REPO_PATH/gcc-arm-none-eabi-10.3-2021.10"
OBJDUMP_PATH="$GCC_ARM_PATH/bin/arm-none-eabi-objdump"

for firmware in "${!firmware_info[@]}"; do
    echo "Setting up $firmware..."
    
    if tmux has-session -t $firmware 2>/dev/null; then
        echo "Warning: tmux session '$firmware' already exists. Skipping..."
        continue
    fi
    
    board_mcu=(${firmware_info[$firmware]})
    board=${board_mcu[0]}
    mcu=${board_mcu[1]}
    
    tmux new-session -d -s $firmware
    
    WORKING_DIR="$REPO_PATH/fuzzing/$firmware/1/"
    tmux send-keys -t $firmware "WORKING_DIR=$WORKING_DIR" C-m
    tmux send-keys -t $firmware "mkdir -p \$WORKING_DIR" C-m
    tmux send-keys -t $firmware "cd \$WORKING_DIR" C-m
    
    tmux send-keys -t $firmware "cp $REPO_PATH/externals/p2im-real_firmware/binary/$firmware \$WORKING_DIR/$firmware" C-m
    
    tmux send-keys -t $firmware "cp -r $REPO_PATH/fuzzing/templates/seeds/ \$WORKING_DIR/inputs" C-m
    
    tmux send-keys -t $firmware "cp $REPO_PATH/fuzzing/templates/fuzz.cfg.template \$WORKING_DIR/fuzz.cfg" C-m
    

    tmux send-keys -t $firmware "sed -i 's|<repo_path>|$REPO_PATH|g' \$WORKING_DIR/fuzz.cfg" C-m
    tmux send-keys -t $firmware "sed -i 's|<firmware_name>|$firmware|g' \$WORKING_DIR/fuzz.cfg" C-m
    tmux send-keys -t $firmware "sed -i 's|<fuzzing_run_num>|1|g' \$WORKING_DIR/fuzz.cfg" C-m
    tmux send-keys -t $firmware "sed -i 's|<board_name>|$board|g' \$WORKING_DIR/fuzz.cfg" C-m
    tmux send-keys -t $firmware "sed -i 's|<mcu_name>|$mcu|g' \$WORKING_DIR/fuzz.cfg" C-m
    tmux send-keys -t $firmware "sed -i 's|<firmware_elf_file_name>|$firmware|g' \$WORKING_DIR/fuzz.cfg" C-m
    tmux send-keys -t $firmware "sed -i 's|<path_of_arm-none-eabi-objdump>|$OBJDUMP_PATH|g' \$WORKING_DIR/fuzz.cfg" C-m
    tmux send-keys -t $firmware "sed -i 's|%(base)s/qemu/precompiled_bin/qemu-system-gnuarmeclipse|/p2im/qemu/src/install/debian64/qemu/bin/qemu-system-gnuarmeclipse|g' \$WORKING_DIR/fuzz.cfg" C-m
    
    echo "$firmware setup completed!"
done

echo "All firmware setup completed!"
echo "Available tmux sessions:"
tmux list-sessions

echo ""
echo "To start fuzzing, attach to a session and run:"
echo "tmux attach -t <firmware_name>"
echo "Then run: $REPO_PATH/model_instantiation/fuzz.py -c fuzz.cfg"