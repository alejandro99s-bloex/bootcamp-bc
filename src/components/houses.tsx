import styles from '@/styles/components/House.module.css'
import React from 'react';
import { HousesProps } from "../types/index";

interface HomeContract {
    name: string;
    price: number;
    amountPaid: number;
}

type HomeBodyProps = {
    houses: Array<HousesProps> | undefined,
    contribute: Function
    yieldHouse: Function
}

const HousesProfile: React.FC<HomeBodyProps> = ({ houses, contribute, yieldHouse }) => {
    return <>
        <div className={styles.house_body}>
            {houses && (
                houses.map((house: HousesProps, index: number) =>
                    <div key={index} onClick={() => { }} className={`${styles.house_body__element} `}>
                        <form onSubmit={e => contribute(house, e)}>
                            <img src={house.tokenUri} alt={`house_${index}`} height={60} />
                            <div><b>Nombre:</b> {house.name}</div>
                            <div><b>Precio:</b> {`$${house.price.toLocaleString('es-CO')} COP`}</div>
                            <div><b>Descripción:</b> {house.description}</div>
                            <input type="number" id="amount" />
                            <div className={styles.house_body_element__buttons}>
                                <button className={`${styles.house_body_element__buttons__ok} ${styles.house_body__buttons__element}`} type="submit">Realizar aporte</button>
                                <button className={`${styles.house_body_element__buttons__reject} ${styles.house_body__buttons__element}`} onClick={() => yieldHouse(house)}>Liberar leasing</button>
                            </div>
                        </form>
                    </div>
                )
            )}
        </div>
    </>
}
export default HousesProfile

