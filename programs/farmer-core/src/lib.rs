#![allow(unexpected_cfgs)]

use crate::instructions::*;
use anchor_lang::prelude::*;

pub mod errors;
pub mod instructions;
pub mod states;

declare_id!("5NzjPYN5PUGNVkTRfh8naDqD7K3hTQbYyZb5YhtCArxV");

#[program]
pub mod farmer_core {
    use super::*;

    /// Initializes the program configuration account
    pub fn initialize(
        ctx: Context<InitConfig>,
        logistics_wallet: Pubkey,
        paused: bool,
        allowed_mints: Vec<Pubkey>,
    ) -> Result<()> {
        init_config(ctx, logistics_wallet, paused, allowed_mints)
    }
}
