// module config_module::to_do_list_module_v1_01 {
//     use std::string;
//     use std::signer;
//     use std::vector;

//     // Error codes
//     /// Error: The to-do list already exists for this account.
//     const E_LIST_ALREADY_EXISTS: u64 = 1;
//     /// Error: The to-do list was not found for this account.
//     const E_TODO_LIST_NOT_FOUND: u64 = 2;
//     /// Error: The task index is out of bounds.
//     const E_TASK_INDEX_OUT_OF_BOUNDS: u64 = 3;
//     /// Error: The caller is not the owner of the to-do list.
//     const E_NOT_OWNER: u64 = 4;

//     struct Task has copy, drop, store {
//         content: vector<u8>,
//         is_completed: bool
//     }

//     struct ToDoList has key {
//         tasks: vector<Task>,
//         owner: address
//     }

//     public entry fun create_to_do_list(account: &signer) {
//         let addr = signer::address_of(account);
//         assert!(!exists<ToDoList>(addr), E_LIST_ALREADY_EXISTS);

//         let new_list = ToDoList {
//             tasks: vector::empty<Task>(),
//             owner: addr
//         };
//         move_to<ToDoList>(account, new_list);
//     }

//     public entry fun add_task(account: &signer, content: string::String) acquires ToDoList {
//         let addr = signer::address_of(account);
//         let content_parsed = content.bytes();
//         assert!(exists<ToDoList>(addr), E_TODO_LIST_NOT_FOUND);
//         let list = borrow_global_mut<ToDoList>(addr);

//         let new_task = Task { content: *content_parsed, is_completed: false };
//         list.tasks.push_back(new_task);
//     }

//     public entry fun mark_completed(account: &signer, task_index: u64) acquires ToDoList {
//         let addr = signer::address_of(account);
//         assert!(exists<ToDoList>(addr), E_TODO_LIST_NOT_FOUND);
//         let list = borrow_global_mut<ToDoList>(addr);
//         let list_len = list.tasks.length();
//         assert!(task_index < list_len, E_TASK_INDEX_OUT_OF_BOUNDS);
//         let task = &mut list.tasks[task_index];
//         task.is_completed = true;
//     }

//     #[view]
//     public fun get_tasks(owner: address): vector<Task> acquires ToDoList {
//         assert!(exists<ToDoList>(owner), E_TODO_LIST_NOT_FOUND);
//         borrow_global<ToDoList>(owner).tasks
//     }
// }

