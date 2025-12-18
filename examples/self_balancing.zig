const std = @import("std");
const bpt = @import("bplustree").BPlusTree(i32, i32, 4);

pub fn main() !void {
    var dbga: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbga.deinit();

    var tree = bpt.init(dbga.allocator());
    defer tree.deinit();

    // Insert enough keys to force multiple splits and balancing
    const N = 1024 * 1024;
    var k: i32 = 0;
    while (k < N) : (k += 1) {
        try tree.insert(k, k * 10);
    }

    // Check all keys are present
    var all_found = true;
    k = 0;
    while (k < N) : (k += 1) {
        const v = tree.search(k);
        if (v == null or v.? != k * 10) {
            std.debug.print("Key {d} not found or incorrect value: {any}\n", .{ k, v });
            all_found = false;
        }
    }
    if (all_found) {
        std.debug.print("All {d} keys found and correct.\n", .{N});
    }

    // Optionally, print the root node's key count to check balance
    if (tree.root) |r| {
        std.debug.print("Root node has {d} keys.\n", .{r.n});
    }
}
