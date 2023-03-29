export interface User {
    address: string;
    name: string;
    cc: number;
    capacity: number;
}

export interface HousesProps {
    name: string;
    price: number;
    minimumContribution: number;
    description: string;
    tokenUri: string;
    isAvailable: boolean;
    owner?: string;
    id: number;
}

export interface MyHouse {
    tokenUri: string;
    description: string;
    buttonOk: string;
    onAccept: Function;
    buttonCancel: string;
    onCancel: Function;
  }