{{
    config(
        schema = 'flashliquidity_base',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v2_trades(
        blockchain = 'base',
        project = 'flashliquidity',
        version = '1',
        Pair_evt_Swap = source('flashliquidity_base', 'FlashLiquidityPair_evt_Swap'),
        Factory_evt_PairCreated = source('flashliquidity_base', 'FlashLiquidityFactory_evt_PairCreated')
    )
}}
