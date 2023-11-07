THIRD_PARTY_DIR="$(PWD)/third_party"
VEXRISCV_DIR="${THIRD_PARTY_DIR}/VexRiscv"

.PHONY: vexriscv
vexriscv:
	cd ${VEXRISCV_DIR} && sbt "runMain vexriscv.demo.GenFull"

