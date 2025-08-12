module config_module::counter {
    use std::signer;

    //Error codes
    /// The caller is not the owner of the counter.
    const E_NOT_OWNER: u64 = 1;
    /// The counter does not exist.
    const E_COUNTER_NOT_EXIST: u64 = 2;
    /// The counter already exist.
    const E_COUNTER_ALREADY_EXIST: u64 = 3;
    struct Counter has key {
        owner: address,
        count: u64
    }

    public entry fun create_counter(account: &signer) {
        let address = signer::address_of(account);
        assert!(!exists<Counter>(address), E_COUNTER_ALREADY_EXIST);

        let new_counter = Counter { owner: address, count: 0 };
        move_to<Counter>(account, new_counter);
    }

    public entry fun increment(account: &signer) acquires Counter {
        let address = signer::address_of(account);
        assert!(exists<Counter>(address), E_COUNTER_NOT_EXIST);

        let counter = borrow_global_mut<Counter>(address);
        assert!(counter.owner == address, E_NOT_OWNER);
        counter.count += 1;
    }

    #[view]
    public fun get_counter(owner: address): u64 acquires Counter {
        assert!(exists<Counter>(owner), E_COUNTER_NOT_EXIST);
        let counter = borrow_global<Counter>(owner);
        assert!(counter.owner == owner, E_NOT_OWNER);
        counter.count
    }
}

