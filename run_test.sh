# ====================================================================
# STUDENT D VALIDATION MODULE: SORTED VERIFICATION
# ====================================================================
echo "=================================================="
echo "[STUDENT D] Running Sorted Verification Checks..."
echo "=================================================="

if [ ! -f "result_sorted.dat" ]; then
    echo "[FAIL] Student D Error: result_sorted.dat was not generated!"
    exit 1
fi

# Use an embedded Python call to verify integers are sorted ascending
python3 -c '
import struct
import sys

try:
    with open("result_sorted.dat", "rb") as f:
        data = f.read()
    
    # Unpack file data as 32-bit signed integers
    count = len(data) // 4
    integers = struct.unpack(f"{count}i", data)
    
    # Scan array structure
    for i in range(len(integers) - 1):
        if integers[i] > integers[i+1]:
            print(f"[FAIL] Sorting violation discovered at index {i}: {integers[i]} > {integers[i+1]}")
            sys.exit(1)
            
    print("[PASS] Validation Complete: result_sorted.dat is successfully sorted ascending.")
except Exception as e:
    print(f"[FAIL] Verification script execution crashed: {e}")
    sys.exit(1)
'

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Student D Verification Passed Successfully."
else
    echo "[FAIL] Student D Verification Found Ordering Anomalies."
    exit 1
fi
