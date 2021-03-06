<?php
    function evalTask1($accumulator, $pc, &$task1Completed, $previousPCs) {
        if (in_array($pc, $previousPCs)) {
            echo "Task 1 answer: $accumulator\n";
            $task1Completed = true;
        }
    }

    $a = 0;
    $program = file("input4.in");
    
    $previousPCs = [];
    $task1Completed = false;
    $iterations = 0;
    $changedPC = 0;
    $firstIteration = true;
    $len = count($program);

    for ($pc = 0; $pc < $len;) {
        $tmp = explode(" ", $program[$pc]);
        $opcode = $tmp[0];
        $offset = intval($tmp[1]);
        $pc++;
        $iterations++;


        if (!$task1Completed) {
            evalTask1($a, $pc, $task1Completed, $previousPCs);
        }
        array_push($previousPCs, $pc);

        switch ($opcode) {
            case "nop": break;

            case "acc":
                $a += $offset;
                break;
            
            case "jmp":
                $pc--;
                $pc += $offset;
                break;

            default: echo "Unimplemented instruction $opcode\n"; break;
        }

        # if iterations > number of instructions, assume an infinite loop
        if ($iterations > $len && $task1Completed) { // swap a NOP/JMP and rerun
            $pc = 0; # reset state
            $a = 0;
            $iterations = 0;
            if (!$firstIteration && strpos($program[$changedPC], "nop") !== false) { # fix the last replaced opcode
                $program[$changedPC] = str_replace("nop", "jmp", $program[$changedPC]);
            }

            else if (!$firstIteration && strpos($program[$changedPC], "jmp") !== false) {
                $program[$changedPC] = str_replace("jmp", "nop", $program[$changedPC]);
            }

            for ($i = $changedPC + 1; $i < count($program); $i++) { # Find a new opcode to replace
                if (strpos($program[$i], "nop") !== false) {
                    $program[$i] = str_replace("nop", "jmp", $program[$i]);
                    $changedPC = $i;
                    break;
                }

                else if (strpos($program[$i], "jmp") !== false) {
                    $program[$i] = str_replace("jmp", "nop", $program[$i]);
                    $changedPC = $i;
                    break;
                }
            }

            $previousPCs = [];
            $firstIteration = false;
        }
    }
    
    echo "[Task 2] Accumulator after exit was $a\n";
?>
