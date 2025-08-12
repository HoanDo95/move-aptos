// module config_module::my_first_module {
//     use std::string::{String};
//     use std::signer;

//     const E_MESSAGE_NOT_FOUND: u64 = 1;

//     struct MessageHolder has key {
//         message: String,
//         last_updated_timestamp: u64
//     }
    
//     public entry fun set_message(account: &signer, msg_bytes: vector<u8>) {
//         let addr = signer::address_of(account);
//         let message_str = std::string::utf8(msg_bytes);

//         let new_message = MessageHolder {
//             message: message_str,
//             last_updated_timestamp: aptos_framework::timestamp::now_seconds()
//         };

//         move_to<MessageHolder>(account, new_message);
//     }

//     #[view]
//     public fun get_message(owner: address): String acquires MessageHolder {
//         assert!(exists<MessageHolder>(owner), E_MESSAGE_NOT_FOUND);

//         borrow_global<MessageHolder>(owner).message
//     }
// }